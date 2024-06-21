function out = createMatrixCoordinate( n,m )
% n : number of elements Ox
% m : number of elements Oy
n = input('The number of element x : ')
m = input('The number of elemant y : ')
%dr = zeros(2,a); 
dx = zeros(1,n); 
for i = 1 : n
dx(1,i) = i-1;
end
dy = zeros(1,m); 
for i = 1 : m
dy(1,i) = i-1;
end
out.dx = dx;
out.dy = dy;
end

