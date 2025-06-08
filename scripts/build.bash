#!/usr/bin/env bash

set -euo pipefail
ME=$(basename "$0")


info() {
    f=$1
    shift
    >&2 echo "[  INFO  ] $ME:$f(): $*"
}


main() {
    info $FUNCNAME "Building the project..."
    mkdir -p build
    cp -R slides build
    build-plantuml
    build-marp
    info $FUNCNAME "Build completed successfully."
}


build-plantuml() {
    info $FUNCNAME "Building SVG diagrams..."
    for d in $(find slides -type d); do
        info $FUNCNAME "Processing: $d/"
        bin/plantuml -failfast -tsvg "/data/build/$d"
    done
}


build-marp() {
    info $FUNCNAME "Building HTML slides..."
    bin/marp -I "/home/marp/app/build"

    info $FUNCNAME "Building PDF slides..."
    bin/marp -I "/home/marp/app/build" --pdf

    info $FUNCNAME "Building PPTX slides..."
    bin/marp -I "/home/marp/app/build" --pptx
}


main "$@"
