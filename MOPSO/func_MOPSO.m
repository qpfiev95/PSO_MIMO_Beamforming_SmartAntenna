function out = func_MOPSO(problem, params)

    %% Problem Definiton
    CostFunction = problem.CostFunction;  % Cost Function
    nVarX = problem.nVarX;        % Number of Unknown (Decision) Variables
    nVarY = problem.nVarY;
    VarSizeX = nVarX;
    VarSizeY = nVarY;
    %VarSize = [1 nVar];         % Matrix Size of Decision Variables
    VarMin = problem.VarMin;	% Lower Bound of Decision Variables
    VarMax = problem.VarMax;    % Upper Bound of Decision Variables
    
      %% Parameters of PSO

    MaxIt = params.MaxIt;   % Maximum Number of Iterations
    nPop = params.nPop;     % Population Size (Swarm Size)
    nRep = params.nRep;     % Repository Size
    w = params.w;           % Intertia Coefficient
    wdamp = params.wdamp;   % Damping Ratio of Inertia Coefficient
    c1 = params.c1;         % Personal Acceleration Coefficient
    c2 = params.c2;         % Social Acceleration Coefficient
    
    nGrid = params.nGrid;   % Number of Grids per dimention
    alpha = params.alpha;   % Inflation Rate (t? l? l?m phát)
    beta = params.beta;     % Leader Selection Pressure
    gamma = params.gamma;   % Deletion Selection Pressure
    mu = params.mu;         % Mutation Rate (ti le dot bien)
    

       % The Flag for Showing Iteration Information
    %ShowIterInfo = params.ShowIterInfo;    
    MaxVelocity = 0.2*(VarMax-VarMin);
    MinVelocity = -MaxVelocity;
    
     %% Initialization

    % The Particle Template
    empty_particle.PositionX = [];
    empty_particle.PositionY = [];
    empty_particle.VelocityX = [];
    empty_particle.VelocityY = [];
    empty_particle.Cost = [];
    empty_particle.Best.PositionX = [];
    empty_particle.Best.PositionY = [];
    empty_particle.Best.Cost = [];
    empty_particle.IsDominated = [];
    empty_particle.GridIndex = [];
    empty_particle.GridSubIndex = [];
    
     % Create Population Array
    particle = repmat(empty_particle, nPop, 1);
    
     % Initialize Population Members
    for i=1:nPop

        % Generate Random Solution
        %particle(i).Position = unifrnd(VarMin, VarMax, VarSize);
        particle(i).PositionX = random_2(VarSizeX);
        particle(i).PositionY = random_2(VarSizeY);
        % Initialize Velocity
        particle(i).VelocityX = zeros(1,VarSizeX);
        particle(i).VelocityY = zeros(1,VarSizeY);
        % Initialize Cost funciton
       particle(i).Cost = CostFunction(particle(i).PositionX, particle(i).PositionY);
        
        % Update Personal Best
        particle(i).Best.PositionX = particle(i).PositionX;
        particle(i).Best.PositionY = particle(i).PositionY;
        particle(i).Best.Cost = particle(i).Cost;
        
    end
    
    % Determine Domination : Xac dinh su uu tien (thong tri)
    particle = func_DetermineDomination(particle,nVarX,nVarY);
    %  cac ca the khong bi thong tri (cac ca the chiem uu the) vao kho REP => ~ : LOGICAL NOT
    rep =  particle(~[particle.IsDominated]);
    % Tao luoi cho cac ca the trong kho REP : ho tro cho viec tao Pareto
    % Front
    Grid = func_CreateGrid(rep,nGrid,alpha);
    % Gan cac he so cua luoi bao vao ca the trong rep  
    for i=1:numel(rep)
        rep(i)= func_FindGridIndex(rep(i),Grid);
    end
    
    %% MOPSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        leader = func_SelectLeader(rep,beta,VarSizeX,VarSizeY);
         cc1 = rand([1 VarSizeX]);
         cc2 = rand([1 VarSizeX]);
         
         ccc1 = rand([1 VarSizeY]);
         ccc2 = rand([1 VarSizeY]);
         
         % Compute velocity
         particle(i).VelocityX = w*particle(i).VelocityX ...
            +c1*cc1.*(particle(i).Best.PositionX - particle(i).PositionX) ...
            +c2*cc2.*(leader.PositionX - particle(i).PositionX);
         particle(i).VelocityY = w*particle(i).VelocityY ...
            +c1*ccc1.*(particle(i).Best.PositionY - particle(i).PositionY) ...
            +c2*ccc2.*(leader.PositionY - particle(i).PositionY);
        
         % Apply velocity limit :
         particle(i).VelocityX = max(particle(i).VelocityX, MinVelocity);
         particle(i).VelocityX = min(particle(i).VelocityX, MaxVelocity);
         particle(i).VelocityY = max(particle(i).VelocityY, MinVelocity);
         particle(i).VelocityY = min(particle(i).VelocityY, MaxVelocity);
         
         % Update Position
           % Apply Lower and Upper Bound Limits (***)
            particle(i).PositionX = newPos(particle(i).PositionX,particle(i).VelocityX,VarMax);
            particle(i).PositionX = (max(particle(i).PositionX, VarMin));
            particle(i).PositionX = (min(particle(i).PositionX, VarMax));
            particle(i).PositionY = newPos(particle(i).PositionY,particle(i).VelocityY,VarMax);
            particle(i).PositionY = (max(particle(i).PositionY, VarMin));
            particle(i).PositionY = (min(particle(i).PositionY, VarMax));
         % Compute Cost function 
            particle(i).Cost = CostFunction(particle(i).PositionX,particle(i).PositionY);
            
         % Apply Mutation (Su Dot Bien) : 
          pm =(1-(it-1)/(MaxIt-1))^(1/mu);
        if rand < pm
            NewSol.PositionX = Mutate(particle(i).PositionX,pm,VarMin,VarMax);
            NewSol.PositionY = Mutate(particle(i).PositionY,pm,VarMin,VarMax);
            NewSol.Cost=CostFunction(NewSol.PositionX,NewSol.PositionY);
            if func_Dominates(NewSol,particle(i))
                particle(i).PositionX = NewSol.PositionX;
                particle(i).PositionY = NewSol.PositionY;
                particle(i).Cost=NewSol.Cost;

            elseif func_Dominates(particle(i),NewSol)
                % Do Nothing

            else
                if rand < 0.5
                    particle(i).PositionX = NewSol.PositionX;
                    particle(i).PositionY = NewSol.PositionY;
                    particle(i).Cost = NewSol.Cost;
                end
            end
        end
        
        % Apply Gobal best
        if func_Dominates(particle(i),particle(i).Best)
            particle(i).Best.PositionX = particle(i).PositionX;
            particle(i).Best.PositionY = particle(i).PositionY;
            particle(i).Best.Cost = particle(i).Cost;
            
        elseif func_Dominates(particle(i).Best,particle(i))
            % Do Nothing
            
        else
            if rand < 0.5
                 particle(i).Best.PositionX = particle(i).PositionX;
                 particle(i).Best.PositionY = particle(i).PositionY;
                particle(i).Best.Cost = particle(i).Cost;
            end
        end
         figure(1);
    func_PlotCosts(particle,rep);
    pause(0.01);
    end
         % Add Non-Dominated Particles to REPOSITORY
    rep=[rep
         particle(~[particle.IsDominated])]; %#ok
    
    % Determine Domination of New Resository Members
    rep = func_DetermineDomination(rep,nVarX,nVarY);
    rep = func_AfterDetermineDomination(rep);
    
    % Keep only Non-Dminated Memebrs in the Repository
    rep=rep(~[rep.IsDominated]);
    rep = makeunique(rep);
    % Update Grid
    Grid = func_CreateGrid(rep,nGrid,alpha);

    % Update Grid Indices
    for i=1:numel(rep)
        rep(i) = func_FindGridIndex(rep(i),Grid);
    end
    
    % Check if Repository is Full
    if numel(rep)>nRep
        
        Extra = numel(rep)-nRep;
        for e=1:Extra
            rep = func_DeleteOneRepMemebr(rep,gamma);
        end
        
    end
    
    % Plot Costs
   figure(2);
    func_PlotCosts(particle,rep);
    pause(0.01);
    
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of Rep Members = ' num2str(numel(rep))]);
    
    % Damping Inertia Weight
    w=w*wdamp;
    
end

%% Resluts
 
out.particle = particle;
out.rep = rep;
out.leader = leader;
              
end        


    
 
          
        