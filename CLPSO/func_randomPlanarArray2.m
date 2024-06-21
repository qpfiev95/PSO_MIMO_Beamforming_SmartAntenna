function [ x ] = func_randomPlanarArray2(VarMin, VarMax, VarSize)
   x = zeros(VarSize,1);
   x(:,1) =sort(VarMin + (VarMax-VarMin)*rand(VarSize,1),'ascend');
   x =x';
end

