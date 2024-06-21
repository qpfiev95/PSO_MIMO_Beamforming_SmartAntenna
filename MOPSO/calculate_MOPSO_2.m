
clc;
clear;
close all;

%% Problem Definition

problem.CostFunction=@(x,y) fitness_2(x,y);      % Cost Function
problem.nVarX = 5;             % Number of Decision Variables
problem.nVarY = 5; 
%problem.VarSize = 9 ;   % Size of Decision Variables Matrix
problem.VarMin = 0;          % Lower Bound of Variables
problem.VarMax = 8;          % Upper Bound of Variables


%% MOPSO Parameters

params.MaxIt = 50;           % Maximum Number of Iterations
params.nPop = 100;            % Population Size
params.nRep = 50;            % Repository Size

params.w = 1;              % Inertia Weight
params.wdamp = 0.9;         % Intertia Weight Damping Rate
params.c1 = 1.5;               % Personal Learning Coefficient
params.c2 = 1.5;               % Global Learning Coefficient

params.nGrid = 10;            % Number of Grids per Dimension
params.alpha=0.1;          % Inflation Rate

params.beta=2;             % Leader Selection Pressure
params.gamma=2;            % Deletion Selection Pressure

params.mu=0.1;             % Mutation Rate

%% Calling MOPSO

out = func_MOPSO(problem, params);
plotInfo = func_plotBeamPattern( out.leader.PositionX,out.leader.PositionY );
SLL_Max = func_minSll(out.leader.PositionX,out.leader.PositionY) 
HPBW = func_HPBW(out.leader.PositionX,out.leader.PositionY)