% Demo for disparitysparse.m and nanmedfilt2_kmeans.m
% Usage
% [SparseDisparityMap] = sparse_disparity(Left_image,Right_image,DisparityRange,WindowSize,Method,DisparityCheck);

% DisparityRange = [dmin, dmax]; must be vector with 2 values
% WindowSize = [positive odd number] must be odd scalar
% DisparityCheck = [minGroup, maxRange]; must be vector with 2 values
% minGroup --> minimum disparity values to form a group
% maxRange --> range of values to form a group
% if a group doesn't pass disparity check is labeled as NaN

% Available Methods (Default SAD):
% SAD --> Sum of Absolute Differences
% NCC --> Normalized Cross Correlation
% Hamming --> Hamming distance
% Jaccard --> Jaccard measure
% MutualInformation --> Entropy-based measure

% Occlusions are labeled as NaN values

% [DenseDisparityMap] = nanmedfilt2_kmeans(SparseDisparityMap,Left,WindowSize);

% SparseDisparityMap --> 2d-Array NaN values as occlusions to be filled
% Left --> RGB Left image from stereo pair
% windowSize --> [positive odd number] must be odd scalar
% To visualize D, imshow(D,[DisparityRange])

% If you find useful this functions please cite:

% V. Gonzalez-Huitron, V. Ponomaryov, E. Ramos-Diaz, and S. Sadovnychiy,
% “Parallel framework for dense disparity map estimation using Hamming 
% distance,” Signal, Image Video Process., vol. 12, no. 2, pp. 231–238,
% Feb. 2018. doi.org/10.1007/s11760-017-1150-3

% Conrad Sanderson and Ryan Curtin.
% Armadillo: a template-based C++ library for linear algebra.
% Journal of Open Source Software, Vol. 1, pp. 26, 2016.

%% Example 1
L = imread('stereoimages/TsukubaL.png');
R = imread('stereoimages/TsukubaR.png');
DisparityRange = [0 16];
WindowSize = 9;
Method = 'NCC';
DisparityCheck=[12,4];
D_sparse=sparse_disparity(L,R,DisparityRange,WindowSize,Method,DisparityCheck);
D=nanmedfilt2_kmeans(D_sparse,L,WindowSize);
figure,
imshow(D,DisparityRange);
title(['Disparity map - ' Method]);
colormap jet; colorbar;
%% Example 2
L = imread('stereoimages/im0L.png');
R = imread('stereoimages/im1R.png');
DisparityRange = [0 128];
WindowSize = 15;
D_sparse=sparse_disparity(L,R,DisparityRange,WindowSize);
D=nanmedfilt2_kmeans(D_sparse,L,WindowSize);
figure,
imshow(D,DisparityRange);
title(['Disparity map - SAD']);
colormap jet; colorbar;
%% Example 3
L = imread('stereoimages/KITTI000123_L.png');
R = imread('stereoimages/KITTI000123_R.png');
DisparityRange = [0 80];
WindowSize = 11;
Method = 'Jaccard';
D_sparse=sparse_disparity(L,R,DisparityRange,WindowSize,Method);
D=nanmedfilt2_kmeans(D_sparse,L,WindowSize);
figure,
imshow(D,DisparityRange);
title(['Disparity map - ' Method]);
colormap jet; colorbar;
