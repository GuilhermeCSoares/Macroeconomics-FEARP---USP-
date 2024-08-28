% Função pra computar o excesso de demanda no mercado de ativos
function [excDem, V, gk, stationary_dist, w, Kd, Ea] = ExcessDemand(alpha, beta, gamma, delta, n_grid, k_grid, Pi, N, M, Nbar, r, V)
    % Computando a demanda e os salários da economia
    Kd = (alpha / (r + delta))^(1 / (1 - alpha)) * Nbar;
    w = (1 - alpha) * (Kd / Nbar)^alpha; %vem da Cobb-Douglas
 
    % Resolve o problema das familias fazendo iterações da função valor
    fprintf('\nComeçando a iteração da função valor...\n');
    [V, gk] = compute_policy(beta, gamma, n_grid, k_grid, Pi, N, M, V, r, w);

    % Computa a distribuição invariante do capital e produtividade
    fprintf('\nComeçando a iteração da distribuição invariante...\n');
    stationary_dist = compute_invariant_dist(gk, Pi, N, k_grid);

    % Computa excesso de demanda no mercado de ativos
    Ea = sum(sum(stationary_dist .* gk)); % Oferta de ativos (sum of optimal savings)
    excDem = (Ea - Kd) / ((Ea + Kd) / 2); % Excesso de demanda como proporção do capital médio
end