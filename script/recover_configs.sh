#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

# find the installers and run them iteratively
find . -name recover.sh | while read recover ; do sh -c "${recover}" ; done

