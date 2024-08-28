clc
clear
close all
%Modelo - Aiyagari
%% Parametros
%No paper ele colocou alpha = 0.36
alpha = 0.36; 
%No paper ele colocou beta = 0.96
beta = 0.96; %beta de macro U.S.A padrão anual
%No paper ele testa a aversão ao risco(no paper sigma) com 3 valroes
%{1,3,5}
gamma = 3; % aversão relativa ao risco
%no paper ele colocou o delta = 0.08
delta = 0.08; %tx de depreciação

%% grids
n_grid = [0.2 0.5 1.1]; %como se tivesse uma produtividade alta e baixa
M = length(n_grid);  %tamanho do grid

% parâmetros da matriz de Markov
p11 = 0.7; % probabilidade de permanecer no estado 1 (baixo)
p12 = 0.2; % probabilidade de ir do estado 1 para o estado 2 (médio)
p13 = 0.1; % probabilidade de ir do estado 1 para o estado 3 (alto)

p21 = 0.3; % probabilidade de ir do estado 2 para o estado 1 (baixo)
p22 = 0.5; % probabilidade de permanecer no estado 2 (médio)
p23 = 0.2; % probabilidade de ir do estado 2 para o estado 3 (alto)

p31 = 0.1; % probabilidade de ir do estado 3 para o estado 1 (baixo)
p32 = 0.2; % probabilidade de ir do estado 3 para o estado 2 (médio)
p33 = 0.7; % probabilidade de permanecer no estado 3 (alto)

% matriz de transição 3x3
Pi = [p11 p12 p13; 
      p21 p22 p23; 
      p31 p32 p33];

inv_Pi = Pi^1000;
inv_Pi = inv_Pi(1,:); %distribuição invariante da matriz Pi
Nbar = sum(n_grid .* inv_Pi);  %Calculando trabalho agregado 

N = 200; %numero de pontos
kmax = 25; %capital maximo
k_grid = linspace(0,kmax, N); %grid do capital




