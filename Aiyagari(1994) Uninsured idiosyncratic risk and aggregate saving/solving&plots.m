%% Resolvendo o modelo
% Comece a função valor com ZEROS
V = zeros(N, M);

% Resolvendo e iterando até achar o equilibrio
tic
[V, gk, stationary_dist, w, Kd, Ea, r, excDem] = ModelSolution(alpha, beta, gamma, delta, n_grid, k_grid, Pi, N, M, Nbar, V);
toc

%% Plotando Resultados

% Plot Função Valor
figure(1)
plot(k_grid, V(:,1), 'LineWidth', 1.5); hold on;
plot(k_grid, V(:,2), 'LineWidth', 1.5);
title('Função Valor V(a, y)');
xlabel('Capital');
ylabel('Valor');
legend('n_l', 'n_h','Location','best');
grid on;

% Plot Função Politica
figure(2)
plot(k_grid, gk(:,1), 'LineWidth', 1.5); hold on;
plot(k_grid, gk(:,2), 'LineWidth', 1.5);
plot(k_grid, k_grid, 'k--'); % linha de 45°para comparação 
title('Função Politica');
xlabel('Ativos');
ylabel('Politica');
legend('n_l', 'n_H', '45°','Location','best');
grid on;

% Plotando distribuição estacionaria do capital
figure(3)
plot(k_grid, sum(stationary_dist, 2), 'LineWidth', 1.5);
title('Distribuição Estacionaria');
xlabel('Ativos (a)');
ylabel('Probabilidade');
grid on;

%% Analisando desigualdade

% Plotando distribuição estacionaria cumulativa
figure(4)
plot(k_grid, cumsum(sum(stationary_dist, 2)), 'LineWidth', 1.5);
title('Distribuição Estacionaria Cumulativa');
xlabel('Ativos (a)');
ylabel('Probabilidade');
grid on;

% Plotando curva de lorenz
figure(5)
plot(cumsum(sum(stationary_dist, 2)), k_grid/kmax, 'LineWidth', 1.5);
title('Curva de Lorenz');
xlabel('Massa cumulativa');
ylabel('% de ativos');
grid on;
