function b=func_Dominates(x,y)
% x is said to dominate to y : x chiem uu the hõn y 
% <=> ALL x <= y  AND  ANY x < y 
% x => gia tri cua cac ham muc tieu
    if isstruct(x)
        x=x.Cost;
    end
    
    if isstruct(y)
        y=y.Cost;
    end

    b = all(x<=y) && any(x<y);

end