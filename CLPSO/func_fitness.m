function z = func_fitness(dx,dy)
load('Data/Matrix_dl.mat');
load('Data/Matrix_dlx.mat');
load('Data/Matrix_dly.mat');
Sir = func_maxSIR(dlx,dly);
Sll = func_minSll(dlx,dly);
%Sir = 5178;
%Sll = 0.3166;
maxSir = func_maxSIR(dx,dy);
minSll = func_minSll(dx,dy);
 
 z = (maxSir - Sir) + 1000000*(Sll - minSll);

end

