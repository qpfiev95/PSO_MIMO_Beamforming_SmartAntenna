function leader = func_SelectLeader(rep,beta,n,m)
 
dlx = zeros(1,n); 
for i = 1 : n
dlx(1,i) = i-1;
end
dly = zeros(1,m); 
for i = 1 : m    
dly(1,i) = i-1;
end

cost = rep.Cost;
    for i = 1 : numel(rep)    
        sll(i) = rep(i).Cost(2);
        hpbw(i) = rep(i).Cost(1);
    end
    
    % sll values in rep
    sllmax = max(sll);
    sllmin = min(sll);
    % HPBW values in rep
    hpbwmax = max(hpbw);
    hpbwmin = min(hpbw);
    % Values of uniform linear array : 
    %SIR = func_maxSIR(dlu);
    SLL = func_minSll(dlx,dly);
    HPBW = func_HPBW(dlx,dly);
    noptimal = 0;
    poptimal = zeros(1,numel(rep));
    for j = 1 : numel(rep) 
    cost1(j) = (hpbwmax - hpbw(j))/(hpbwmax - hpbwmin);
    cost2(j) = (sllmax - sll(j))/(sllmax - sllmin);
        if sll(j) < SLL && hpbw(j) < HPBW
            noptimal = noptimal + 1;
            poptimal(j) = 1;
        end
    end  
    % Find out number of optimal points and position of these points :
    poptimal = find(poptimal == 1);
    costoptimal = max(cost1(poptimal) + cost2(poptimal));
    %costmax = max(cost1 + cost2);
       

%% Chon ca the dai dien trong kho luu tru REP
    % beta : he so lua chon ca the dai dien
    
    % Grid Index of All Repository Members
    GI=[rep.GridIndex];    
    % Occupied Cells (cac te bao chua cac ca the khong bi thong linh (non-dominated) ) 
    % unique => no repeation => Moi cell chua cac ca the co cung gridIndex
    OC = unique(GI);    
    % => Number of Particles in Occupied Cells
    N = zeros(size(OC));
    for k=1:numel(OC)
        N(k) = numel(find(GI==OC(k)));
    end
    
    % Selection Probabilities
    P=exp(-beta*N);
    P=P/sum(P);
    
    % Selected Cell Index
    sci=RouletteWheelSelection(P);
    
    % Selected Cell
    sc=OC(sci);
    
    % Selected Cell Members
    SCM = find(GI==sc);
    
    % Selected Member Index
    smi = randi([1 numel(SCM)]);
    
    % Selected Member
    sm = SCM(smi);
    
    % Leader : ca the dai dien
%     if noptimal == 0
        leader=rep(sm);
%      else
%          leader = rep(find(cost1 + cost2 == costoptimal,1,'first'));
%      end
end