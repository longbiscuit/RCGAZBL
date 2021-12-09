% author: Binglong Zhu ; Date: 2021.12.9
% Email: blzhu@buaa.edu.cn or sdszbl@163.com
% reference: https://yarpiz.com/
%            https://faculty.csu.edu.cn/michael_x_zhou/zh_CN/jxzy/74762/content/1459.htm

clc;
clear;
close all;
currentFolder = pwd;
addpath(genpath(currentFolder))
%% Problem Definition

% problem.CostFunction = @(x) Sphere(x);
% problem.nVar = 5;
% problem.VarMin = [-10 -10 -5 -1 -5];
% problem.VarMax = [ 10  10  5  1 8];

problem.CostFunction = @(x) SquareFunc(x);%蠕变沉降实用算法
problem.nVar = 2;
problem.VarMin = [0 0];
problem.VarMax = [300 300];


% problem.CostFunction = @(x) ackley(x);
% problem.nVar =2;
% problem.VarMin = -1500*ones(1,2);
% problem.VarMax = 3000*ones(1,2);

% problem.CostFunction = @(x) ChenxianyunFunc(x);%超级难
% problem.nVar =2;
% problem.VarMin = [0 0];
% problem.VarMax = [30 30];

%% GA Parameters

params.MaxIt =5000;
params.nPop = problem.nVar*20;
% params.nPop = max(50,problem.nVar*20);

params.beta = 1;
params.pC = 1;
params.gamma = 0.1;
params.mu = 0.02;
params.sigma = 0.1;
params.etaC=2;% [2,5]

%% Run GA

out = RunGA(problem, params);


%% Results

figure;
% plot(out.bestcost, 'LineWidth', 2);
semilogy(out.bestcost, '-.or','LineWidth', 1);
xlabel('Iterations');
ylabel('Best Cost');
grid on;
out.bestsol.Position


