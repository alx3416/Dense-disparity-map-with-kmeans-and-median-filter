% KMEANS applied to images in CIELAB colorspace, only a and b channels are
% used to culstering segmentation
function [L]=Kmeans_Lab2019(Im,k,It)
a=colorspace('RGB->Lab',im2double(Im));
L_a = (double(a(:,:,2)));
L_b = (double(a(:,:,3)));
nrows = size(L_a,1);
ncols = size(L_a,2);
L_a = reshape(L_a,nrows*ncols,1);
L_b = reshape(L_b,nrows*ncols,1);

L_a = normalize(L_a);
L_b = normalize(L_b);

X=L_a;
X(:,2)=L_b;
%nuestros datos a usar con k-means son la matriz abL
label_vector = kmeans(X,k,'MaxIter',It);
L = reshape(label_vector,nrows,ncols);