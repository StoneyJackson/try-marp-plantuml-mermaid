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
    for f in $(find "${BUILD_DIR}" -type f -name "*.j2"); do
        info $FUNCNAME "Processing: $f"
        f="${f#$PROJ_ROOT/}"
        jinja "$f" -o "${f%.*}"
    done
}


jinja() {
    "${BIN_DIR}/jinja" "$@"
}


build-mermaid() {
    for f in $(find "${BUILD_DIR}" -type f -name "*.md"); do
        if cat "$f" | grep 'mermaid: true' ; then
            f="build/${f#${BUILD_DIR}/}"
            info $FUNCNAME "Processing: $f"
            mermaid -i "$f" --outputFormat png
        fi
    done
}


mermaid() {
    "${BIN_DIR}/mermaid" "$@"
}


build-plantuml() {
    for f in $(find "${BUILD_DIR}" -type f -name "*.md"); do
        if cat "$f" | grep 'plantuml: true' ; then
            f="build/${f#${BUILD_DIR}/}"
            info $FUNCNAME "Processing: $f"
            plantuml -failfast -tsvg "${f}"
        fi
    done
}


plantuml() {
    "${BIN_DIR}/plantuml" "$@"
}


build-marp() {
    for f in $(find "${BUILD_DIR}" -type f -name "*.md"); do
        if cat "$f" | grep 'marp: true' ; then
            f="build/${f#${BUILD_DIR}/}"
            info $FUNCNAME "Processing: $f"
            marp "$f"
        fi
    done
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
