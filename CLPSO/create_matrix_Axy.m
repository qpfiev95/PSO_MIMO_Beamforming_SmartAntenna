%% Create the matrix Axy : 
clear all;
close all;
n = input('The number of element x : ')
m = input('The number of elemant y : ')
%dr = zeros(2,a); 
dlx = zeros(1,n); 
for i = 1 : n
dlx(1,i) = i-1;
end
dly = zeros(1,m); 
for i = 1 : m    
dly(1,i) = i-1;
end

%% Create matrix coordinate of NxM elements :
dxx = zeros(n,m);
dyy = zeros(n,m);
for i = 1 : m-1
    dxx(:,1) = 0;
    dxx(:,i+1) = dxx(:,i) + 1;
    for j = 1 : n-1
        dxx(1,:) = 0;
        dxx(j+1,:) = dxx(j,:) + 1;
    end
end

for i = 1 : m-1
    dyy(:,1) = 0;
    dyy(:,i+1) = dyy(:,i) + 1;
    for j = 1 : n-1
        dyy(j+1,:) = dyy(j,:);
    end
end
dxx;
dyy;
%d = interleave2(dxx,dyy,'col')
d = [dxx dyy];
d = reshape(d,[n*m,2]);
dl = d';

SllMax = func_minSll(dlx,dly)
HPBW = func_HPBW(dlx,dly)
SirMax = func_maxSIR(dlx,dly)
func_plotBeamPattern(dlx,dly);

save('Data/Matrix_dl','dl')
save('Data/Matrix_dlx','dlx')
save('Data/Matrix_dly','dly')































