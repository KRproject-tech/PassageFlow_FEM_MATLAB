#include "mex.h"

void mexFunction(int nlhs, mxArray *out[], int nrhs, const mxArray *in[] ){
	
	double x, y;

	x = mxGetScalar(in[0]);

	y = 2.0*x;
	
	out[0] = mxCreateDoubleScalar(y);
}