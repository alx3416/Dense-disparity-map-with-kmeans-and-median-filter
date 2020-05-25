    #include "mex.h"
    #include "math.h"
    #define ARMA_DONT_USE_WRAPPER
    #include "C:\armadillo-6.5\include\armadillo"
    #include "omp.h"
     
    using namespace arma;
     
    void matlab2arma(mat& A, const mxArray *mxdata){
    // delete [] A.mem; // don't do this!
    access::rw(A.mem)=mxGetPr(mxdata);
    access::rw(A.n_rows)=mxGetM(mxdata); // transposed!
    access::rw(A.n_cols)=mxGetN(mxdata);
    access::rw(A.n_elem)=A.n_rows*A.n_cols;
    };
     
    void freeVar(mat& A, const double *ptr){
    access::rw(A.mem)=ptr;
    access::rw(A.n_rows)=1; // transposed!
    access::rw(A.n_cols)=1;
    access::rw(A.n_elem)=1;
    };
     
    void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
    {
    if (nrhs != 3)
    mexErrMsgTxt("Incorrect number of input arguments");
    //if (nlhs != 1)
    //mexErrMsgTxt("Incorrect number of output arguments");
     
    mat D1(1,1);
    const double* D1mem=access::rw(D1.mem);
    matlab2arma(D1,prhs[0]); // First create the matrix, then change it to point to the matlab data.
     
    mat D2(1,1);
    const double* D2mem=access::rw(D2.mem);
    matlab2arma(D2,prhs[1]);
    
    mat D3(1,1);
    const double* D3mem=access::rw(D3.mem);
    matlab2arma(D3,prhs[2]);
       
    // check if the input corresponds to what you are expecting
    //if( D1.n_rows != D2.n_rows )
    //mexErrMsgTxt("Columns of D1 and D2 must be of equal length!");
     
    //if( D1.n_cols != D2.n_cols )
    //mexErrMsgTxt("Rows of D1 and D2 must be of equal length!");
     
    plhs[0] = mxCreateDoubleMatrix(D1.n_rows, D1.n_cols, mxREAL);
    mat output(1,1);
    const double* outputmem=access::rw(output.mem);
    matlab2arma(output,plhs[0]);
    // D1 imagen esla grises
    // D2 kernel
    // D3 L
    int p=((D2.n_cols-1)/2);
    //vec  y = zeros<vec>(D2.n_cols*D2.n_cols);
    //vec  L = zeros<vec>(D2.n_cols*D2.n_cols);
    //uvec q1 = zeros<uvec>(D2.n_cols*D2.n_cols);
    
    #pragma omp parallel for
    for(uword j=p; j<D1.n_rows-p; ++j)
    {
        for(uword i=p; i<D1.n_cols-p; ++i)
    {
           
                  
           if (D1(j,i)<0){ //Solo se aplica a -Inf
                vec y=(vectorise(D1(span(j-p,j+p),span(i-p,i+p))));
           
                uvec q1 = find((vectorise(D3(span(j-p,j+p),span(i-p,i+p)))) == D3(j,i)); // Posiciones del cluster en ventana de interes
           
                vec q = y(q1);
                vec Q = (q.elem(find_finite(q)));
                //#pragma omp critical(dataupdate)
           
                if(! (Q.is_empty())) //Si el bloque tiene valores reales 
                { //Se obtiene la mediana de solo esos valores
                output(j,i) = median((q.elem(find_finite(q))));
                //output(j,i) = 50;
                }
                else
                { //Si en el bloque son solo NaN
                output(j,i)=0;
                    //output(j,i)=100;
                }
           }
           else //Si el elemento no es NaN
           {
               output(j,i)=D1(j,i);
               //output(j,i)=200;
           }
    }
    }
         
    freeVar(D1,D1mem); // Change back the pointers!!
    freeVar(D2,D2mem);
    freeVar(D3,D3mem);
    freeVar(output,outputmem);
    return;
    }
    