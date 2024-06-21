function out  = func_HPBW(dx,dy)
load('Data/Matrix_s.mat');
load('Data/Matrix_b.mat');
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
theta= 0:.01:pi; 
ang=theta*180/pi; 
aa =  zeros(idx,length(theta));
iy = 0;
for i = 1 : length(theta)
    x = 1;
    iy = iy + 1;
   for j = 1 : idx
       aa(x,iy) = exp((dl(:,j))'*b(:,i)); 
       x = x+1;
   end
end

for i = 1 : length(theta)
    y(i) = w'*aa(:,i);
end
 
%% Calculate Haft power Beam Width :
 % Find theta_peak :
 da = ma(1);
 da = round(ma(1)*100);
  for i = (da - 5) : (da + 5)
     if (round((abs(y(i))/max(abs(y))).^2,1) == 1)        
         a = i;
     end
     theta_peak = a/100;
  end
     theta_peak = theta_peak*100; 
%%-----------------------------------------------------------
a = find((round((abs(y)/max(abs(y))).^2,1) == 0.5),1,'first');
b = find((round((abs(y)/max(abs(y))).^2,1) == 0.5),1,'last');

        out = round((b - a)*(180/315),3);

end
