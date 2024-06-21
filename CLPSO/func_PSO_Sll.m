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
     flag = 0;
    MaxIt = params.MaxIt;   % Maximum Number of Iterations
    nPop = params.nPop;     % Population Size (Swarm Size)
    m = params.m;           % Refeshing Gap m
    w0 = params.w0;           % Intertia Coefficient
    w1 = params.w1;
    flag = 0;
    c = params.c;         % Personal Acceleration Coefficient

    % The Flag for Showing Iteration Information
    ShowIterInfo = params.ShowIterInfo;    
    MaxVelocity = 1;
    MinVelocity = -1;
    
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
    empty_particle.LearningProbability = [];
    % Create Population Array
    particle = repmat(empty_particle, nPop, 1);
    
    % Initialize Global Best
    %GlobalBest.Cost = inf;
     GlobalBest.Cost = inf;
    % Initialize Population Members
    for i=1:nPop
         particle(i).LearningProbability = 0.05 + 0.45*(exp(10*(i-1)-1))/(exp(10)-1);
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
    cc1 = rand([1 VarSizeX]);
   
    ccc1 = rand([1 VarSizeY]);
   
     for it=1:MaxIt
        for i=1:nPop
              % Calculate w 
            w(i) = w0*(w0-w1)*it/MaxIt; 
            % Choose leader
            particle(i).Best = func_SelectLeader(particle,flag,m,nPop,i);
            % Update Velocity
            particle(i).VelocityX = w(i)*particle(i).VelocityX ...
                + c*cc1.*(particle(i).Best.PositionX - particle(i).PositionX);
                
             particle(i).VelocityY = w(i)*particle(i).VelocityY ...
                + c*ccc1.*(particle(i).Best.PositionY - particle(i).PositionY);
         
            % Apply Velocity Limits
            particle(i).VelocityX = max(particle(i).VelocityX, MinVelocity);
            particle(i).VelocityX = min(particle(i).VelocityX, MaxVelocity);
           
            particle(i).VelocityY = max(particle(i).VelocityY, MinVelocity);
            particle(i).VelocityY = min(particle(i).VelocityY, MaxVelocity);
           
            % Update Position

            % Apply Lower and Upper Bound Limits
             particle(i).PositionX = newPos(particle(i).PositionX,particle(i).VelocityX,VarMax);
            particle(i).PositionX = (max(particle(i).PositionX, VarMin));
            particle(i).PositionX = (min(particle(i).PositionX, VarMax));
            %particle(i).PositionY = newPos(particle(i).PositionY,particle(i).VelocityY,VarMax);
             particle(i).PositionY = particle(i).PositionY + particle(i).VelocityY;
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
                flag = 0;
                 % Update Global Best
                if particle(i).Best.Cost < GlobalBest.Cost
                    GlobalBest = particle(i).Best;
                end
            else
                flag = flag + 1 ;
            end
        end
         % Store the Best Cost Value
        BestCosts(it) = GlobalBest.Cost;
%         if it>2 
%             if BestCosts(it) == BestCosts(it-1);
%             flag = flag + 1;
%             else
%                 flag = 0;
%             end
%         end
%          if flag == 9
%              break
%          end

        % Display Iteration Information
        if ShowIterInfo
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCosts(it)) ': flag = ' num2str(flag)]);
        end
     end

    out.pop = particle;
    out.BestSol = GlobalBest;
    out.BestCosts = BestCosts;
end