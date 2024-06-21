close all
load('Data/Matrix_dlx.mat');
load('Data/Matrix_dly.mat');
%% Problem Definiton

problem.CostFunction = @(x,y) func_minSll(x,y);  % Cost Function
problem.nVarX = 5;       % Number of Unknown (Decision) Variables
problem.nVarY = 5;
problem.VarMin =  0;  % Lower Bound of Decision Variables
problem.VarMax =  8;   % Upper Bound of Decision Variables

%% Parameters of PSO

params.MaxIt = 50;        % Maximum Number of Iterations
params.nPop = 100;           % Population Size (Swarm Size)
params.w0 = 0.9;               % Intertia Coefficient
params.w1 = 0.4;  
params.c = 1.5;  
params.m = 7;  % Personal Acceleration Coefficient              % Social Acceleration Coefficientparams.ShowIterInfo = true; % Flag for Showing Iteration Informatin
params.ShowIterInfo = true; % Flag for Showing Iteration Informatin

%% Calling PSO

out = func_PSO_Sll(problem, params);

BestSol = out.BestSol;
BestCosts = out.BestCosts;

%% Results

figure;
% plot(BestCosts, 'LineWidth', 2);
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

func_plotBeamPattern(out.BestSol.PositionX,out.BestSol.PositionY)
maxSIR = func_maxSIR(out.BestSol.PositionX,out.BestSol.PositionY)
maxSIR_uniform = func_maxSIR(dlx,dly)
minSLL = func_minSll(out.BestSol.PositionX,out.BestSol.PositionY)
minSLL_uniform = func_minSll(dlx,dly)
HPBW = func_HPBW(out.BestSol.PositionX,out.BestSol.PositionY)
