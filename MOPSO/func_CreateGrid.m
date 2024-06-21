function Grid = func_CreateGrid(pop,nGrid,alpha)
    % Gia tri cua cac ham muc tieu
    c=[pop.Cost];
    
    % min(a,[],dim) : dim = 2 => return min value of the column
    cmin = min(c,[],2);
    cmax = max(c,[],2);
    
    dc = cmax-cmin;
    % alpha : inflation rate (ti so lam phat) TH : alpha = 0.1
    cmin = cmin - alpha*dc;
    cmax = cmax + alpha*dc;
    % size(A,dim) : dim = 1 => return the number of column in matrix
    nObj = size(c,1);
    
    empty_grid.LB = [];
    empty_grid.UB = [];
    % repmat : return nObj copies in the row 
    Grid = repmat(empty_grid,nObj,1);
    for j=1:nObj
        
        cj=linspace(cmin(j),cmax(j),nGrid+1);
        Grid(j).LB=[-inf cj];
        Grid(j).UB=[cj +inf];
        
    end

end