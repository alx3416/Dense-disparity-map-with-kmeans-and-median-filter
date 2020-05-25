# Dense disparity map with kmeans and median filter
 median filter and kmeans for dense disparity map estimation
MATLAB functions to fill a sparse disparity map, in consequence, creating a dense disparity map. DEMO.m contains three examples with Tsukuba, Middlebury, and KITTI stereo datasets.

As input, the sparse disparity map must have NaN labels for occluded values, the reference RGB image and a minimum window size to perform the filtering.
First the RGB reference image is color segmented from CIELab colorspace' 'a' and 'b' channels, then the median filtering stage is performed iteratively, beginning with a minimum window size, and then increasing its dimensions until there isn't NaN values or there isn't a value change between iterations

![Flow diagram](https://raw.githubusercontent.com/alx3416/Dense-disparity-map-with-kmeans-and-median-filter/master/FiguresCMF.png)

MEX functions were done with Armadillo linear algebra library, libgomp.dll is required to perform parallel processing

Conrad Sanderson and Ryan Curtin.
Armadillo: a template-based C++ library for linear algebra.
Journal of Open Source Software, Vol. 1, pp. 26, 2016.

If this work is helpful to you, please cite this work

V. Gonzalez-Huitron, V. Ponomaryov, E. Ramos-Diaz, and S. Sadovnychiy, “Parallel framework for dense disparity map estimation using Hamming 
distance,” Signal, Image Video Process., vol. 12, no. 2, pp. 231–238, Feb. 2018.

doi.org/10.1007/s11760-017-1150-3
