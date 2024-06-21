function [ dxy ] = func_randomPlanarArray( VarMin, VarMax, VarSizeX, VarSizeY )
     
    a = sort(VarMin + (VarMax-VarMin)*rand(VarSizeX,1),'ascend');
    
    b = sort(VarMin + (VarMax-VarMin)*rand(VarSizeY,1),'ascend');
   
    
    %% Create matrix coordinate of NxM elements :
n = VarSizeX;  m = VarSizeY;
dxx = zeros(n,m);
dyy = zeros(n,m);
    for j = 1 : n
        dxx(j,:) = a(j);
    end
    for j = 1 : m
        dyy(:,j) = b(j);
    end
dxy = [dxx dyy]
dxy = reshape(dxy,[n*m,2])
dxy = dxy';
end

