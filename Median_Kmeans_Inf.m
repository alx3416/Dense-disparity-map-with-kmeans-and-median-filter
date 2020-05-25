%MEDIAN_KMEANS_INF performs local median filtering only in pixels labeled
%as Inf, in each iteration the local median is calculated only with
%values from the same cluster K as the center pixel
function D=Median_Kmeans_Inf(ddpp,p,L)
ddpp(ddpp==0 | isnan(ddpp))=-Inf;
ddpp = padarray(ddpp,[ceil(3*p/2) ceil(3*p/2)],'both','symmetric');
D=ddpp;
[m,n]=size(D);
L = padarray(L,[ceil(3*p/2) ceil(3*p/2)],'both','symmetric');
D=NANcluster_medfilt2(ddpp,ones(p),L);
D(D==0)=NaN;
D=D(ceil(3*p/2)+1:m-ceil(3*p/2),ceil(3*p/2)+1:n-ceil(3*p/2));