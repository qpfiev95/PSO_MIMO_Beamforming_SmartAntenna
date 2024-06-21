function particle = func_FindGridIndex(particle,Grid)
    % so luong ham muc tieu xet : number of Objective functions
    nObj = numel(particle.Cost);
    % So luong luoi : cj=linspace(cmin(j),cmax(j),nGrid+1);
    % Grid(j).LB=[-inf cj];
    nGrid = numel(Grid(1).LB);    
    particle.GridSubIndex = zeros(1,nObj);
    
    for j=1:nObj  
    %  find(a,n,'first/last') : finds the first n nonzero elements.
        particle.GridSubIndex(j)=...
            find(particle.Cost(j) < Grid(j).UB,1,'first');  
    end

    particle.GridIndex = particle.GridSubIndex(1);
    for j=2:nObj
        particle.GridIndex = particle.GridIndex - 1;
        particle.GridIndex = nGrid*particle.GridIndex;
        particle.GridIndex  = particle.GridIndex + particle.GridSubIndex(j);
    end
    
end