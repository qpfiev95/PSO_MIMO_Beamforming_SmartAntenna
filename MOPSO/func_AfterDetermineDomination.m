function pop = func_AfterDetermineDomination(pop)
    % nPop : so luong ca the 
%%--------------
  
    nPop = numel(pop);
    for i = 1 : nPop
        pop(i).IsDominated=false;
    end
    
    for i=1:nPop-1
        for j=i+1:nPop
            % func_Dominates(pop(i),pop(j))= 1 => pop(j) is dominated by pop(i)
            % costfunction(pop(i)) < costfunction(pop(j)) => pop(j) bi
            % thong tri <=> pop(i) chiem uu the
            if func_Dominates(pop(i),pop(j))
               pop(j).IsDominated=true;
            end
            % func_Dominates(pop(j),pop(i))= 1 => pop(i) is dominated by pop(j)  
            % pop(i) bi thong tri <=> pop(j) chiem uu the
            if func_Dominates(pop(j),pop(i))
               pop(i).IsDominated=true;
            end
            
        end
    end
    
end