#!/usr/bin/env bash

main() {
    set -euo pipefail
    echo "Building the project..."

    bin/plantuml -tsvg -filedir "/data" -o /data/build/slides/ch2 /data/slides/ch2
    cp slides/ch2/*.md build/slides/ch2
    
    echo "Build completed successfully."
}

main "$@"
