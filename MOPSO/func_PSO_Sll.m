function out = func_PSO_Sll(problem, params)

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
    w = params.w;           % Intertia Coefficient
    wdamp = params.wdamp;   % Damping Ratio of Inertia Coefficient
    c1 = params.c1;         % Personal Acceleration Coefficient
    c2 = params.c2;         % Social Acceleration Coefficient
    % The Flag for Showing Iteration Information
    ShowIterInfo = params.ShowIterInfo;    
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
    
    % Create Population Array
    particle = repmat(empty_particle, nPop, 1);
    
    % Initialize Global Best
    %GlobalBest.Cost = inf;
     GlobalBest.Cost = inf;
    % Initialize Population Members
    for i=1:nPop
        % Generate Random Solution
        particle(i).PositionX = random_2(VarSizeX);
        particle(i).PositionY = random_2(VarSizeY);
        % Initialize Velocity
        particle(i).VelocityX = zeros([1 VarSizeX]);
        particle(i).VelocityY = zeros([1 VarSizeY]);
        % Evaluation => CostFunction : maxSIR
        particle(i).Cost = CostFunction(particle(i).PositionX, particle(i).PositionY);
        % Update the Personal Best
        
        particle(i).Best.PositionX = particle(i).PositionX;
        particle(i).Best.PositionY = particle(i).PositionY;
        particle(i).Best.Cost = particle(i).Cost;
        
        if particle(i).Best.Cost < GlobalBest.Cost
            GlobalBest = particle(i).Best;
        end
        
    end
    
     % Array to Hold Best Cost Value on Each Iteration
    BestCosts = zeros(MaxIt, 1);
    
    %% Main Loop of PSO
  
   
     for it=1:MaxIt
        for i=1:nPop
            % Update Velocity
             cc1 = rand([1 VarSizeX]);
             cc2 = rand([1 VarSizeX]);
   
             ccc1 = rand([1 VarSizeY]);
             ccc2 = rand([1 VarSizeY]);
            particle(i).VelocityX = w*particle(i).VelocityX ...
                + c1*cc1.*(particle(i).Best.PositionX - particle(i).PositionX) ...
                + c2*cc2.*(GlobalBest.PositionX - particle(i).PositionX);
             particle(i).VelocityY = w*particle(i).VelocityY ...
                + c1*ccc1.*(particle(i).Best.PositionY - particle(i).PositionY) ...
                + c2*ccc2.*(GlobalBest.PositionY - particle(i).PositionY);
            % Apply Velocity Limits
            particle(i).VelocityX = max(particle(i).VelocityX, MinVelocity);
            particle(i).VelocityX = min(particle(i).VelocityX, MaxVelocity);
           
            particle(i).VelocityY = max(particle(i).VelocityY, MinVelocity);
            particle(i).VelocityY = min(particle(i).VelocityY, MaxVelocity);
           
            % Update Position
            particle(i).PositionX = particle(i).PositionX + particle(i).VelocityX;
            particle(i).PositionX = sort(particle(i).PositionX,'ascend');
            particle(i).PositionY = particle(i).PositionY + particle(i).VelocityY;
            particle(i).PositionY = sort(particle(i).PositionY,'ascend');
            
            % Apply Lower and Upper Bound Limits
            particle(i).PositionX = (max(particle(i).PositionX, VarMin));
            particle(i).PositionX = (min(particle(i).PositionX, VarMax));
            
            particle(i).PositionY = (max(particle(i).PositionY, VarMin));
            particle(i).PositionY = (min(particle(i).PositionY, VarMax));
            %particle(i).Position = sort(particle(i).Position,'ascend');
           
            
            % Evaluation : maxSIR(particle(i).Posotion) => maxSIR(dxy)
            particle(i).Cost = CostFunction(particle(i).PositionX,particle(i).PositionY);

            % Update Personal Best
            if particle(i).Cost < particle(i).Best.Cost

                particle(i).Best.PositionX = particle(i).PositionX;
                 particle(i).Best.PositionY = particle(i).PositionY;
                particle(i).Best.Cost = particle(i).Cost;
                 % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = particle(i).Best;
                end            
            end
        end
         % Store the Best Cost Value
        BestCosts(it) = GlobalBest.Cost;

        % Display Iteration Information
        if ShowIterInfo
            disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it))]);
        end

        % Damping Inertia Coefficient
        w = w * wdamp;

     end

    out.pop = particle;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
end