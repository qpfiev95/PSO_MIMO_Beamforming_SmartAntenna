load('Data/Matrix_s.mat');
load('Data/Matrix_s2.mat');
load('Data/Matrix_s3.mat');
load('Data/Matrix_s4.mat');
load('Data/Matrix_ma.mat');
load('Data/Matrix_ma2.mat');
load('Data/Matrix_ma3.mat');
load('Data/Matrix_ma4.mat');
dx = out.BestSol.PositionX;
dy = out.BestSol.PositionY;
figure

plot1 = func_plotInfo2( dx,dy,s,ma);
plot2 = func_plotInfo2( dx,dy,s2,ma2);
 plot3 = func_plotInfo2( dx,dy,s3,ma3);
plot4 = func_plotInfo2( dx,dy,s4,ma4);
y1 = plot1.y;
y2 = plot2.y;
y3 = plot3.y;
y4 = plot4.y;
theta= 0:.01:2*pi; 
ang=theta*180/pi;
semilogy(ang,(abs(y1)/max(abs(y1))).^2) 
 axis([0 360 0 1]) 
 xlabel('\phi') 
 ylabel('|AF(\phi)|^2')
 grid on
 hold on
 semilogy(ang,(abs(y2)/max(abs(y2))).^2) 
 axis([0 360 0 1]) 
 xlabel('\phi') 
 ylabel('|AF(\phi)|^2')
 grid on
%  hold on
%  semilogy(ang,(abs(y3)/max(abs(y3))).^2) 
%  axis([0 360 0 1]) 
%  xlabel('\phi') 
%  ylabel('|AF(\phi)|^2')
%  grid on
 hold on
 semilogy(ang,(abs(y4)/max(abs(y4))).^2) 
 axis([0 360 0 1]) 
 xlabel('\phi') 
 ylabel('|AF(\phi)|^2')
 grid on
 hold on