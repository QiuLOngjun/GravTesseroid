# GravTesseroid
## About
GravTesseroid is a collection of matlab scripts for modeling the gravitational potential of a tesseroid and its first and second order derivatives.

The geometry of a tesseroid is show in Fig.1
![a geometry of a tesseroid](https://github.com/QiuLOngjun/GravTesseroid/blob/master/images/Fig01.gif "Fig.1")

The first version v1.0 mainly contains fundamental functions for modeling the gravitatinal attraction of a tesseroid and employs three kinds of approaches to perform the forward modeling. These methods are：

1. Gauss-Legendre quadrature (3D GLQ)
2. Taylor series expansion (TSE)
3. prism approximation (PA)

## Getting started
### List of functions 
The GLQ_tess_g3.m, Taylor_tess_g3.m and prism_grav_vector.m are functions that calculate the gravitational attraction of a tesseroid on one computation point using the 3D GLQ, TSE, and PA, respectively.

The Pf_GLQ_grav.m Pf_Taylor_grav.m and Pt_Prism_grav.m are their counterpart of parallel computing using the parfor loop of MATLAB and call for the GLQ_tess_g3.m, Taylor_tess_g3.m and prism_grav_vector.m, respectively. 

