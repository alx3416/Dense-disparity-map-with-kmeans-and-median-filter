
function [D]=nanmedfilt2_kmeans(D,a,p)
[L]=Kmeans_Lab2019(a,8,15);
k=1;
prev_D = D;
D=Median_Kmeans_Inf(prev_D,k+p-1,L);
ciclo = any(isnan(D(:)));
while ciclo
    prev_D = D;
    D=Median_Kmeans_Inf(prev_D,k+p-1,L);
    if isequaln(D,prev_D)
        k=k+2;
        D=Median_Kmeans_Inf(prev_D,k+p-1,L);
    end
    ciclo = any(isnan(D(:)));
end