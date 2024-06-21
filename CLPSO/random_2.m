function [ x ] = random_2(VarSize)
   % Uniformly distribution + interval space between adjacent element [0.1 1]
   x = zeros(1,VarSize);
   a = 1;
    for i = 1 : VarSize-1
        x(1,1) = 0.1 + 0.9*rand(1);
        x(1, a+1 ) = x(1,a) + (0.1+0.9*rand(1));
        a = a + 1;
    end
end