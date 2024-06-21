load('Matrix_dl.mat');
load('Matrix_s.mat');
load('Matrix_b.mat');
%dl = random_1(VarMin, VarMax, VarSize );
[idx,idy] = size(dl');
[idu,idv] = size(s);

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

[Ev,v]=eig(R);                  % calculate eigenvalues and eigenvectors 

[Y,Index]=sort(diag(v));        % sorts the eigenvalues from least to greatest 

SIRmax=max(Y);                  % find maximum SIR 

w=inv(Ruu)*dsav/SIRmax;         % normalize weight vector   or we can find w by 
%w=inv(Rxx)*dsav; 
%%Beam pattern :
theta=0:.01:pi; 
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
z=abs(y)/max(abs(y));
clear x;
 figure;
 plot(ang,(abs(y)/max(abs(y))).^2,'k') 
 axis([0 180 0 1]) 
 xlabel('\theta') 
 ylabel('|AF(\theta)|^2') 
 %%------------------------Plot of The Output Radiation Pattern
 
 figure;
 polarpattern(ang,abs(y)/max(abs(y))) 
 title ( 'The Generalized Null Steering Beam Former Output Radiation Pattern ') , grid on ;
    


