function out = RunGA(problem, params)

% Problem
CostFunction = problem.CostFunction;
nVar = problem.nVar;
VarSize = [1, nVar];
VarMin = problem.VarMin;
VarMax = problem.VarMax;

% Params
MaxIt = params.MaxIt;
nPop = params.nPop;
beta = params.beta;
pC = params.pC;
nC = round(pC*nPop/2)*2;
gamma = params.gamma;
mu = params.mu;
sigma = params.sigma;
etaC=params.etaC;

% Template for Empty Individuals
empty_individual.Position = [];
empty_individual.Cost = [];

% Best Solution Ever Found
bestsol.Cost = inf;

% Initialization
pop = repmat(empty_individual, nPop, 1);
    for i = 1:nPop
        % Generate Random Solution
        pop(i).Position = unifrnd(VarMin, VarMax, VarSize);

        % Evaluate Solution
        pop(i).Cost = CostFunction(pop(i).Position);

        % Compare Solution to Best Solution Ever Found
        if pop(i).Cost < bestsol.Cost
            bestsol = pop(i);
        end
    end

%初始化时尝试更多个随机初始个体
% popIni = repmat(empty_individual, nPop*10, 1);
% for i = 1:nPop*10
%     % Generate Random Solution
%     popIni(i).Position = unifrnd(VarMin, VarMax, VarSize);
%     
%     % Evaluate Solution
%     popIni(i).Cost = CostFunction(popIni(i).Position);
%     
%     % Compare Solution to Best Solution Ever Found
%     if popIni(i).Cost < bestsol.Cost
%         bestsol = popIni(i);
%     end
% end
% 
% % Merge and Sort Populations
% popIni = SortPopulation(popIni);
% 
% % Remove Extra Individuals
% pop = popIni(1:nPop);




% Best Cost of Iterations
bestcost = nan(MaxIt, 1);

% Main Loop
Omega = [1,1e-1,1e-2,1e-3,1e-4,1e-5,1e-6,1e-7,1e-8];
counter=0;
for it = 1:MaxIt
    oldfBest=bestsol.Cost;
    
    % Selection Probabilities
    c = [pop.Cost];
    avgc = mean(c);
    if avgc ~= 0
        c = c/avgc;
    end
    probs = exp(-beta*c);
    
    
    % Initialize Offsprings Population
    popc = repmat(empty_individual, nC/2, 2);
    
    % Crossover
    for k = 1:nC/2
        
        % RouletteWheel Select Parents
        p1 = pop(RouletteWheelSelection(probs));
        p2 = pop(RouletteWheelSelection(probs));
        %Tournament Select Parents
        p3 = pop(TournamentSelection(pop,nPop));
        p4 = pop(TournamentSelection(pop,nPop));
        
        % Perform Crossover
%         CrossFlag=randi(3);%随机选择某个算子
        CrossFlag=3;%只用某个算子
        switch  CrossFlag
            case 1
                % 1-UniformCrossover
                [popc(k, 1).Position, popc(k, 2).Position] = ...
                    UniformCrossover(p1.Position, p2.Position, gamma);
            case 2
                %2-SBXCrossover
                [popc(k, 1).Position, popc(k, 2).Position] = ...
                    SBXCrossover(p1.Position, p2.Position, VarMax,VarMin,etaC);
            case 3
                %3-SPXCrossover 感觉这个算子最好使
                [popc(k, 1).Position] = ...
                    SPXCrossover(p1.Position, p2.Position, VarMax,VarMin,p1.Cost,p2.Cost);
                [ popc(k, 2).Position] = ...
                    SPXCrossover(p3.Position, p4.Position, VarMax,VarMin,p3.Cost,p4.Cost);
        end
    end
    
    % Convert popc to Single-Column Matrix
    popc = popc(:);
    
    % Mutation
    for l = 1:nC
        
        % Perform Mutation
        popc(l).Position = Mutate(popc(l).Position, mu, sigma);
        
        % Check for Variable Bounds
        popc(l).Position = max(popc(l).Position, VarMin);
        popc(l).Position = min(popc(l).Position, VarMax);
        
        % Evaluation
        popc(l).Cost = CostFunction(popc(l).Position);
        
        
        % Compare Solution to Best Solution Ever Found
        if popc(l).Cost < bestsol.Cost
            bestsol = popc(l);
        end
        
    end
    
    % Merge and Sort Populations
    pop = SortPopulation([pop; popc]);
    
    % Remove Extra Individuals
    pop = pop(1:nPop);
    
    % local search 这个局部搜索算子好使
    SE=30;
    Range = [VarMin;VarMax];%
    [bestsol.Position,bestsol.Cost] = rotate_w(CostFunction,bestsol.Position,SE,Range,Omega);
    pop(1).Position  =bestsol.Position;
    pop(1).Cost  =bestsol.Cost;
    
    
    %  termination conditions
    if norm(oldfBest-bestsol.Cost) < 1e-8 % can be changed
        counter = counter + 1;
        if counter > MaxIt/50 % can be changed
            break;
        end
    else
        counter = 0;
    end
    
    % Update Best Cost of Iteration
    bestcost(it) = bestsol.Cost;
    
    % Display Itertion Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(bestcost(it))]);
    
end


% Results
out.pop = pop;
out.bestsol = bestsol;
out.bestcost = bestcost;

end