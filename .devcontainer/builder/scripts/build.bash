#!/usr/bin/env bash


export BUILDER_NAME=builder


set -euo pipefail


SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

export BUILDER_ROOT=$(dirname "$SCRIPT_DIR")
export BIN_DIR="${BUILDER_ROOT}/bin"
export LIB_DIR="${BUILDER_ROOT}/lib"

export PROJ_ROOT=$(git rev-parse --show-toplevel)
export SRC_DIR="${PROJ_ROOT}/src"
export BUILD_DIR="${PROJ_ROOT}/build"


main() {
    info $FUNCNAME "Starting build process..."
    info $FUNCNAME "Cleaning up previous build..."
    clean-previous
    info $FUNCNAME "Copying src into build..."
    copy-src
    info $FUNCNAME "Build jinja documents..."
    build-jinja
    info $FUNCNAME "Build Mermaid images..."
    build-mermaid
    info $FUNCNAME "Build PlantUML images..."
    build-plantuml
    info $FUNCNAME "Build Marp slides..."
    build-marp
    info $FUNCNAME "Build completed successfully."
}


clean-previous() {
    rm -rf "${BUILD_DIR}"
}

copy-src() {
    mkdir -p "${BUILD_DIR}"
    cp -r "${SRC_DIR}/." "${BUILD_DIR}/"
}


build-jinja() {
    # Process all Jinja2 templates and Markdown files in the build directory
    # but not any file that starts with an underscore
    for f in $(find "${BUILD_DIR}" -type f -name "*.j2" ! -name "_*"); do
        info $FUNCNAME "Processing: $f"
        f="${f#$PROJ_ROOT/}"
        jinja "$f" -o "${f%.*}"
    done
}

jinja() {
    "${BIN_DIR}/jinja" "$@"
}

build-mermaid() {
    for f in $(find build -type f -name "*.mmd" -o -name "*.md"); do
        info $FUNCNAME "Processing: $f"
        mermaid -i "$f" -o "${f%.*}.png"
    done
}


mermaid() {
    "${BIN_DIR}/mermaid" "$@"
}


build-plantuml() {
    for d in $(find "${BUILD_DIR}" -type d); do
        info $FUNCNAME "Processing: $d/"
        plantuml -failfast -tsvg "${d#$PROJ_ROOT/}"
    done
}


plantuml() {
    "${BIN_DIR}/plantuml" "$@"
}


build-marp() {
    marp -I "/home/marp/app/build"
    # marp -I "/home/marp/app/build" --pdf
    # marp -I "/home/marp/app/build" --pptx
}


marp() {
    "${BIN_DIR}/marp" "$@"
}


info() {
    local f=$1
    shift
    >&2 echo "[  INFO ] $BUILDER_NAME:$f(): $*"
}


main "$@"
