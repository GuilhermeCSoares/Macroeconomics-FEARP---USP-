%Função pra resolver todas as outras funções do modelo
%Primeiro tem que rodar os parametros da pasta Parametros.m
function [V, gk, stationary_dist, w,Kd, Ea, r, excDem] = ModelSolution(alpha, beta, gamma, delta, n_grid, k_grid, Pi, N, M,Nbar,V)
r0 = 0.001;
r1 = 0.045;

maxIterEq = 100;
tolEq = 0.001;

for iter = 1:maxIterEq 
    rguess = (r0+r1)/2;
    [excDem, V, gk, stationary_dist, w, Kd, Ea] = ExcessDemand(alpha, beta, gamma, delta, n_grid, k_grid, Pi, N, M,Nbar,rguess,V);
    if abs(excDem) < tolEq
        break;
    end
    if excDem < 0
        r0 = rguess;
    else
        r1 = rguess;
    end
    r = (r0 + r1)/2;
    

end