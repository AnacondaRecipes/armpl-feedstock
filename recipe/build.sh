#!/bin/bash
# Repack the armpl binaries.
set -o pipefail,xtrace,nounset

# Untar and delete the version number found between _ and _
# This is intened to make it simpler to maintain between versions
tar -xv --transform='s,_.+_,,' -f arm-performance-libraries.tar
cd arm-performance-libraries || exit 1

# Run installer script
./arm-performance-libraries.sh --accept --install-to "${PREFIX}" --force

# Create the standard installation locations
mkdir "${PREFIX}/include"
mkdir "${PREFIX}/lib"

# Move everything into the standard locations
cp -rn "${PREFIX}"/armpl_*_gcc-*/include*/* "${PREFIX}"/include
cp -rn "${PREFIX}"/armpl_*_gcc-*/lib*/* "${PREFIX}"/lib

# Remove arm specific directories
rm -rf "${PREFIX}"/armpl_*
