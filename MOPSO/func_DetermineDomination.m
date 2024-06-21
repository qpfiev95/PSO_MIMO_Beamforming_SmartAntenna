function pop = func_DetermineDomination(pop,nVarX,nVarY)
    % nPop : so luong ca the 
%%--------------
n = nVarX;
m = nVarY;
dlx = zeros(1,n); 
for i = 1 : n
dlx(1,i) = i-1;
end
dly = zeros(1,m); 
for i = 1 : m    
dly(1,i) = i-1;
end;
 for i = 1 : numel(pop)    
        sll(i) = pop(i).Cost(2);
        hpbw(i) = pop(i).Cost(1);
 end
SLL = func_minSll(dlx,dly);
HPBW = func_HPBW(dlx,dly);
%----------------------------------

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
    
    for i = 1 : nPop       
        if sll(i) < SLL && hpbw(i) < HPBW     
           pop(i).IsDominated = false;
        end
    end
    

end