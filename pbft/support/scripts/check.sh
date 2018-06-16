#!/bin/bash

checkfmt() {
    local files="$(gofmt -l ./src)"
    if [ -n "$files" ]; then
        echo "$files" >&2
        return 1
    fi
}

lint_pkgs() {
    for dir in $(find ./src \
        -mindepth 1 -maxdepth 1 -type d ); do
        echo "$dir/..."
    done
}

lint() {
    gometalinter \
        --disable=gotype \
        --vendor \
        --skip=test \
        --fast \
        --deadline=600s \
        --severity=golint:error \
        --errors \
        ./src/...
}

usage() {
    echo "check.sh fmt|lint" >&2
    exit 2
}

case "$1" in
    fmt) checkfmt ;;
    lint) lint ;;
    *) usage ;;
esac
