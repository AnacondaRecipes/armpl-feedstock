# Repack the armpl binaries.
tar -xvf "${SOURCE_FILENAME}"
cd "${EXTRACTED_SOURCE_DIR}"
./${SOURCE_BINARY}.sh --accept --install-to $PREFIX --force

# Copy shared libs.
mkdir ${PREFIX}/include
mkdir -p ${PREFIX}/lib
cp -rn ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}/include*/* ${PREFIX}/include
cp -rn ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}/lib*/* ${PREFIX}/lib

rm -rf ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}

