function out = func_plotBeamPattern( dx,dy )

load('Data/Matrix_s.mat');
load('Data/Matrix_b.mat');
load('Data/Matrix_b2.mat');
load('Data/Matrix_dlx.mat');
load('Data/Matrix_dly.mat');

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

[Ev,v]=eig(R);                  % calculate eigenvalues and eigenvectors 

[Y,Index]=sort(diag(v));        % sorts the eigenvalues from least to greatest 

SIRmax=max(Y);                  % find maximum SIR 
out.SIRmax = abs(SIRmax);
w=inv(Ruu)*dsav/SIRmax;
out.w = w;

% normalize weight vector   or we can find w by 
%w=inv(Rxx)*dsav; 

%%Beam pattern :
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

%---------------------
AFu = ArrayFactor(dlx,dly);
ylu = AFu.y;
%---------------

out.extremes = func_extrems((abs(y)/max(abs(y))).^2,'strict');
out.y = (abs(y)/max(abs(y))).^2;
out.Sll = func_minSll(dx,dy);

positionMin = out.extremes.minx;
valueMin = out.extremes.miny;
positionMax = out.extremes.maxx;
valueMax = out.extremes.maxy;

clear x;
 figure;
 semilogy(ang,(abs(y)/max(abs(y))).^2,'--') 
 axis([0 360 0 1]) 
 xlabel('\phi') 
 ylabel('|AF(\phi)|^2')
%  title( 'Figure : |AF(\theta)|^2')
 grid on
 hold on
 semilogy(ang,(abs(ylu)/max(abs(ylu))).^2) 
 axis([0 360 0 1]) 
 xlabel('\phi') 
 ylabel('|AF(\phi)|^2')
%  title( 'Figure : |AF(\theta)|^2');
 grid on
  figure;
 plot(theta*100,(abs(y)/max(abs(y))).^2,'k')
  axis([0 630 0 1]) 
  hold on
 plot(positionMin,valueMin,'bs-','lineStyle','none');
 plot(positionMax,valueMax,'mo-','lineStyle','none');
 xlabel('\theta') 
 ylabel('|AF(\theta)|^2')
 title( 'Figure : |AF(\theta)|^2')
 grid on
 %%------------------------Plot of The Output Radiation Pattern
 figure;
 polarpattern(ang,(abs(y)/max(abs(y))).^2) 
 title( 'Beam pattern ') 
 grid on ;

end

