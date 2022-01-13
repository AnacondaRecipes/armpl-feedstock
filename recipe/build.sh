#!/bin/bash
# Repack the armpl binaries.
set -o pipefail
set -o xtrace
set -o nounset

# Run installer script
# This avoids ShellCheck SC2211: https://github.com/koalaman/shellcheck/wiki/SC2211
# First expand the list list of possible matches into an array
INSTALLER=(arm-performance-libraries*.sh)
# Execute the first script found
exec "./${INSTALLER[0]}" --accept --install-to "${PREFIX}" --force || exit 1

# Create the standard installation locations
mkdir "${PREFIX}/include"
mkdir "${PREFIX}/lib"

# Move everything into the standard locations
cp -rvn "${PREFIX}"/armpl_*_gcc-*/include*/* "${PREFIX}"/include
cp -rvn "${PREFIX}"/armpl_*_gcc-*/lib*/* "${PREFIX}"/lib

# Remove arm specific directories
rm -rf "${PREFIX}"/armpl_*
