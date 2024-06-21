function out = func_SelectLeader( particle,flag,m,nPop,i )
if flag >= m
    if particle(i).LearningProbability > rand
        index1 = randi(nPop);
        while index1 == i, index1 = randi(nPop);  end
        index2 = randi(nPop); 
        while index2==i||index2==index1, index2 = randi(nPop);  end
        if particle(index1).Best.Cost < particle(index2).Best.Cost
            out = particle(index1).Best;
        else
             out = particle(index2).Best;
        end 
    else
        out = particle(i).Best; 
    end
    
else
  out = particle(i).Best;
end

end

