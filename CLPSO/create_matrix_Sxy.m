%% Create the spatial frequency vector :   
%sig2 = input('The noise variance : ');
sig2 = 0.001;
phi = pi/2;
%Input Received Signals Arrival :
nt = input ('The Number of received signals arrivals : ');
lamda = 2;
% Designed angle
da = input ('Enter the desired angle  : ') ;
msgbox ('Enter the interference angle :') ;
pause
% Interferent angles
for I = 1 : (nt-1)
    
    O(I) = input ('Enter the interference angle : ') ;
end

s4 = zeros(2,nt);
for i = 1 : nt
    if (i == 1)
    s4(1,i) = -1i*(2*pi/lamda)*cos(da)*sin(phi);
    s4(2,i) = -1i*(2*pi/lamda)*sin(da)*sin(phi);
    else
         s4(1,i) = -1i*(2*pi/lamda)*cos(O(i-1))*sin(phi);
         s4(2,i) = -1i*(2*pi/lamda)*sin(O(i-1))*sin(phi);
    end
end




% Matrix of Angle
ma4 = [da O];
%%AF plot :
theta=0:.01:pi; 
ang=theta*180/pi; 

b = zeros(2,length(theta));
for i = 1 : length(theta)
    th = theta(i);
    b(1,i) = -1i*(2*pi/lamda)*cos(th)*sin(phi);
    b(2,i) = -1i*(2*pi/lamda)*sin(th)*sin(phi);
end

%%BP plot :
theta2 = 0:.01:2*pi; 
ang2 = theta2*180/pi; 

b2 = zeros(2,length(theta2));
for i = 1 : length(theta2)
    th2 = theta2(i);
    b2(1,i) = -1i*(2*pi/lamda)*cos(th2)*sin(phi);
    b2(2,i) = -1i*(2*pi/lamda)*sin(th2)*sin(phi);
end

save('Data/Matrix_ma4','ma4')
save('Data/Matrix_s4','s4')
save('Data/Matrix_b','b')
save('Data/Matrix_b2','b2')