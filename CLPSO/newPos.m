function newposition = newPos(position,velocity,VarMax)

    for i = 1: numel(position)        
            position(i) = position(i) + velocity(i);        
    end
    
    for i = 1:numel(position)-1
        j = i + 1;
        if position(j) < position(i) || position(j) == position(i)
            position(j) = position(i) + (0.2 + 1.6*rand);
        end
    end
%newposition = position*VarMax/(max(position));
newposition = position;
end

