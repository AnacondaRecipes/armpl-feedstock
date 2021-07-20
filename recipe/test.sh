#!/usr/bin/env bash
# Run the tests for armpl

set -ex

exists() {
	FULL_PATH="${PREFIX}/${1}"
	if [ -f "${FULL_PATH}" ]; then
		echo "Found ${1}"
	else
		echo "Could not find ${FULL_PATH}"
		exit 1
	fi
}

for i in include/{armpl,blas,cblas,lapack,lapacke}.h lib/{libarmpl{,_mp,_int64_mp,_int64},libamath,libastring}.so; do
	exists $i
done

# Compile the example and run it
$CC -c -I"${PREFIX}/include" test/fftw_dft_r2c_1d_c_example.c -o fftw_dft_r2c_1d_c_example.o
$CC fftw_dft_r2c_1d_c_example.o -L"${PREFIX}/lib" -o fftw_dft_r2c_1d_c_example -larmpl_lp64 -lgfortran -lm
./fftw_dft_r2c_1d_c_example
