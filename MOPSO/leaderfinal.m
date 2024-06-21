n = numel(out.rep);
cost = out.rep.Cost;
    for i = 1 : n    
        sll(i) = out.rep(i).Cost(2);
        hpbw(i) = out.rep(i).Cost(1);
    end
    
    % sll values in rep
    sllmax = max(sll);
    sllmin = min(sll);
    % HPBW values in rep
    hpbwmax = max(hpbw);
    hpbwmin = min(hpbw);
for i = 1:n
x(i) = (func_HPBW(dlx,dly)-hpbw(i))/(hpbwmax-hpbwmin)+(func_minSll(dlx,dly)-sll(i))/(sllmax-sllmin); 
end
x