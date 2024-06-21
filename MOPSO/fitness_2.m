function z = fitness_2( dx,dy )

%Sir = 5178;
%Sll = 0.3166;
f1 = func_HPBW(dx,dy);
f2 = func_minSll(dx,dy);
 
z=[f1
   f2];
end