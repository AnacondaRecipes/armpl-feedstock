# Repack the armpl binaries.
tar -xvf "${SOURCE_FILENAME}"
cd "${EXTRACTED_SOURCE_DIR}"
./${SOURCE_BINARY}.sh --accept --install-to $PREFIX --force

# Copy include dirs (including symlinks).
cp -rnav ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}/include* ${PREFIX}/

# Copy static libs.
mkdir -p ${PREFIX}/lib
cp -nav ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}/lib/*.a ${PREFIX}/lib

# Copy src dirs.
cp -rnav ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}/src* ${PREFIX}/

rm -rf ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}

# Copy in the site.cfg file for armpl BLAS implementation.
cp ${RECIPE_DIR}/site.cfg ${PREFIX}/site.cfg
