#!/usr/bin/env bash


set -euo pipefail
ME=$(basename "$0")


info() {
    local f=$1
    shift
    >&2 echo "[  INFO ] $ME:$f(): $*"
}


main() {
    info $FUNCNAME "Starting build process..."
    info $FUNCNAME "Cleaning up previous build..."
    clean-previous
    info $FUNCNAME "Copying src into build..."
    copy-src
    info $FUNCNAME "Build Mermaid images..."
    build-mermaid
    info $FUNCNAME "Build PlantUML images..."
    build-plantuml
    info $FUNCNAME "Build Marp slides..."
    build-marp
    info $FUNCNAME "Build completed successfully."
}

clean-previous() {
    rm -rf build
}

copy-src() {
    mkdir -p build
    cp -r src/. build/
}

build-mermaid() {
    for f in $(find build -type f -name "*.mmd" -o -name "*.md"); do
        info $FUNCNAME "Processing: $f"
        bin/mmdc -i "$f" -o "${f%.*}.svg"
    done
}


build-plantuml() {
    for d in $(find build -type d); do
        info $FUNCNAME "Processing: $d/"
        bin/plantuml -failfast -tsvg "$d"
    done
}


build-marp() {
    bin/marp -I "/home/marp/app/build"
    # bin/marp -I "/home/marp/app/build" --pdf
    # bin/marp -I "/home/marp/app/build" --pptx
}


main "$@"
