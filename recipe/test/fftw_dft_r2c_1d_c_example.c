/*
 * fftw_dft_r2c_1d: FFT of a real sequence
 *
 * ARMPL version 21.0 Copyright Arm 2021
 * From: https://developer.arm.com/tools-and-software/server-and-hpc/compile/arm-compiler-for-linux/resources/get-started/armpl-get-started/compile-an-example
 */

#include <armpl.h>
#include <complex.h>
#include <fftw3.h>
#include <math.h>
#include <stdio.h>

int main(void) {
#define NMAX 20
	double xx[NMAX];
	double x[NMAX];
	// The output vector is of size (n/2)+1 as it is Hermitian
	fftw_complex y[NMAX / 2 + 1];

	printf(
	    "ARMPL example: FFT of a real sequence using fftw_plan_dft_r2c_1d\n");
	printf(
	    "----------------------------------------------------------------\n");
	printf("\n");

	/* The sequence of double data */
	int n = 7;
	x[0] = 0.34907;
	x[1] = 0.54890;
	x[2] = 0.74776;
	x[3] = 0.94459;
	x[4] = 1.13850;
	x[5] = 1.32850;
	x[6] = 1.51370;

	// Use dcopy to copy the values into another array (preserve input)
	cblas_dcopy(n, x, 1, xx, 1);

	// Initialise a plan for a real-to-complex 1d transform from x->y
	fftw_plan forward_plan = fftw_plan_dft_r2c_1d(n, x, y, FFTW_ESTIMATE);
	// Initialise a plan for a complex-to-real 1d transform from y->x (inverse)
	fftw_plan inverse_plan = fftw_plan_dft_c2r_1d(n, y, x, FFTW_ESTIMATE);

	// Execute the forward plan and then deallocate the plan
	/* NOTE: FFTW does NOT compute a normalised transform -
	 * returned array will contain unscaled values */
	fftw_execute(forward_plan);
	fftw_destroy_plan(forward_plan);

	printf("Components of discrete Fourier transform:\n");
	printf("\n");
	int j;
	for (j = 0; j <= n / 2; j++)
		// Scale factor of 1/sqrt(n) to output normalised data
		printf("%4d   (%7.4f%7.4f)\n", j + 1, creal(y[j]) / sqrt(n),
		       cimag(y[j]) / sqrt(n));

	// Execute the reverse plan and then deallocate the plan
	/* NOTE: FFTW does NOT compute a normalised transform -
	 * returned array will contain unscaled values */
	fftw_execute(inverse_plan);
	fftw_destroy_plan(inverse_plan);

	printf("\n");
	printf("Original sequence as restored by inverse transform:\n");
	printf("\n");
	printf("       Original  Restored\n");
	for (j = 0; j < n; j++)
		// Scale factor of 1/n to output normalised data
		printf("%4d   %7.4f   %7.4f\n", j + 1, xx[j], x[j] / n);
	return 0;
}
