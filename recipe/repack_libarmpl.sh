# Repack the armpl binaries.
cd armpl
tar -xvf "${SOURCE_FILENAME}"
cd "${EXTRACTED_SOURCE_DIR}"
./${SOURCE_BINARY}.sh --accept --install-to $PREFIX --force

# Copy the relevant libraries.
for i in lib/{libarmpl{,_mp,_int64_mp,_int64},libamath,libastring}.so; do
  cp -rn ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}/$i ${PREFIX}/lib
done

rm -rf ${PREFIX}/armpl_${ARMPL_VERSION}_${GCC_VERSION_STRING}

