function z  = func_minSll(dx,dy)
load('Data/Matrix_s.mat');
load('Data/Matrix_b.mat');
load('Data/Matrix_b2.mat');
load('Data/Matrix_ma.mat');
%% Create matrix coordinate of NxM elements :
n = length(dx);  m = length(dy);
dxx = zeros(n,m);
dyy = zeros(n,m);
    for j = 1 : n
        dxx(j,:) = dx(j);
    end
    for j = 1 : m
        dyy(:,j) = dy(j);
    end
dxy = [dxx dyy];
dxy = reshape(dxy,[n*m,2]);
dl = dxy';
[idx,~] = size(dl');
[~,idv] = size(s);

sig2 = 0.001;


%% 2D array steering matrix :
A = zeros(idx,idv);
ib = 0;
for i = 1 : idv
    a = 1;
    ib = ib +1;
   for j = 1 : idx
       A(a,ib) = exp((dl(:,j))'*s(:,i)); 
       a = a+1;
   end
end

 %desired signal array vector 
   dsav = A(:,1);
 % interferer array vector   
iav = zeros(idx,idv-1);
for j = 1 : idx
    for i = 2 : idv
        iav(j,i-1) = A(j,i);
    end
end

Rss=dsav*dsav.';                % signal correlation matrix
Rnn=sig2*eye(idx);                % noise correlation matrix        
Rii = iav*iav';                  % total interferer correlation matrix 
Ruu=Rii+Rnn;                    % total undesired signal correlation matrix 
Rxx=Ruu+Rss;                    % total array correlation matrix 

R=inv(Ruu)*Rss;  

[~,v]=eig(R);                  % calculate eigenvalues and eigenvectors 

[Y,~]=sort(diag(v));        % sorts the eigenvalues from least to greatest 

SIRmax=max(Y);                  % find maximum SIR 
z = abs(SIRmax);
w=inv(Ruu)*dsav/SIRmax;
% normalize weight vector   or we can find w by 
%w=inv(Rxx)*dsav; 
theta= 0:.01:2*pi; 
ang=theta*180/pi; 
aa =  zeros(idx,length(theta));
iy = 0;
for i = 1 : length(theta)
    x = 1;
    iy = iy + 1;
   for j = 1 : idx
       aa(x,iy) = exp((dl(:,j))'*b2(:,i)); 
       x = x+1;
   end
end

for i = 1 : length(theta)
    y(i) = w'*aa(:,i);

end

extremes = func_extrems((abs(y)/max(abs(y))).^2,'strict');
positionMin = extremes.minx;
valueMin = extremes.miny;
positionMax = extremes.maxx;
valueMax = extremes.maxy;
da = ma(1);
da = round(da*100);
% Ex 0 : 314  => Angle : 90 ; positionMax ~= [120 180] ; valueMax = 1
% pv1 = find(round(valueMax) == 1,1,'first');
% pv2 = find(round(valueMax) == 1,1,'last');
%         maxpoint1 = second_max(valueMax(1:pv1));
%         maxpoint2 = second_max(valueMax(pv2:length(valueMax)));
%         maxpoint =   max(maxpoint1,maxpoint2);
SLLmax = sllmax(valueMax);
 if SLLmax < (abs(y(1))/max(abs(y)))^2 
    SLLmax = max((abs(y(1))/max(abs(y)))^2,(abs(y(315))/max(abs(y)))^2);
 end
  if SLLmax < (abs(y(315))/max(abs(y)))^2 
    SLLmax = max((abs(y(1))/max(abs(y)))^2,(abs(y(315))/max(abs(y)))^2);
 end
for i = (da - 20) :  (da + 20)
    if ((abs(y(i))/max(abs(y)))^2 == 1)
         
         if SLLmax ~= 0
             SLL_max = SLLmax;
         else
             SLL_max = 1;
         end
    end   
end

for i = 1 : ( da - 21 )
    if ((abs(y(i))/max(abs(y)))^2 == 1)
     SLL_max = 1;  
    end   
end

for i =  (da + 21) : 629
    if ((abs(y(i))/max(abs(y)))^2 == 1)
     SLL_max = 1;  
    end   
end

z = 10*log10(SLL_max);

 end
 % Calculate secondMaxSll :
 % z = second_max(valueMax);




