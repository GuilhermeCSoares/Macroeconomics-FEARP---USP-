clc 
clear
close all
% parametros da economia
sigma = 1.5;
beta = 0.9932;
q = 1; 
a_min = -4; %valor minimo do grid
a_max = 4; %valor max do grid
N = 100; % número do grid
e_l = 0.1; %e_low , e  = dotação
e_h = 1; % e_high
%matriz Pi
Pi = [0.5 0.5; 
    1-0.925 0.925];
u = @(c) (c^(1-sigma)) ./ (1-sigma); % './' pra fazer a mult. vetorial('ele entende que é pra pegar cada elemneto do vetor e fazer a operação')
a_grid = linspace(a_min,a_max, N); %espaço de grid de a_min até a_max e tem N pontos
e_grid = [e_l e_h];
% iteração da função valor
V = zeros(N,2); 
TV  =V;
G_pos = V;
G_val = V; 
aux = zeros(N,1);
max_iter = 5000;
iter = 0;
tol = 1e-5; %tolerancia 
dist = 10 %distancia dos steps para convergir

tic %conta os segundos entre operações.

while dist > tol && iter < max_iter %quando dist menor que tolerancia e iteração menor que o limite de iteraçã
    iter = iter + 1;
    for j = 1:2     %  fazer o grid de e
        e = e_grid(j); %e_grid = grid da dotação
        for i = 1:N
            a = a_grid(i);
            for k = 1:N
                a_prime = a_grid(k); %testa se é otimo e pega o melhor? (tala que o consumo é positivo)
                c = a + e - q * a_prime; % esse é o consumo(tem que ser positivo)
                if c>0
                    %aux ta salvando os valores da nossa função valor
                    aux(k) = u(c) + beta * V(k,:)*Pi(j,:)' ;%"ta pegando a linha K"
                    %Não olhar para os casos em que o C é negativo
                else 
                    aux(k) = -inf; %-inf é igual a menos infinito
                    % "se algum a_prime me levaria a valores negativos, não
                    % considerar quando for maximizar"
                end
            end
            [TV(i,j), G_pos(i,j)] = max(aux); %calculei nova função valor levando em consideração os k do grid a_linha
            G_val(i,j) = a_grid(G_pos(i,j));
        end
    end
    dist = max(max(abs(V-TV))); %max(tem 2 maximos pq ele da 1 valor por vetor com a função max                               % do modulo da diferença de V e TV
    V = TV ;
end


%achando distribuição estacionaria 
A_l = zeros(N,N); A_h = A_l;

for i = 1:N
    for j = 1:N
        A_l(i,j) = G_val(i,1) == a_grid(j);
        A_h(i,j) = G_val(i,2) == a_grid(j);
    end
end
toc

% Display resultados
disp('Value function converged');
disp(['Number of iterations: ', num2str(iter)]);
disp('Value function V(a, y):');
%disp(V);

% Plot
figure(1)
plot(a_grid, V(:,1), 'LineWidth', 1.5); hold on;
plot(a_grid, V(:,2), 'LineWidth', 1.5);
title('Value Function V(a, y)');
xlabel('Assets (a)');
ylabel('Value');
legend('y_L', 'y_H','Location','best');
grid on;

figure(2)
plot(a_grid, G_val(:,1), 'LineWidth', 1.5); hold on;
plot(a_grid, G_val(:,2), 'LineWidth', 1.5);
plot(a_grid, a_grid, 'k--');
title('Policy Function');
xlabel('Assets');
ylabel('Policy');
legend('y_L', 'y_H', '45-degree line','Location','best');
grid on;




M = [A_l * Pi(1,1) A_h*Pi(1,2);
     A_l*Pi(2,1)  A_h*Pi(2,2)];
dist_estacionaria = M ^1000;
dist_estacionaria = dist_estacionaria(1,:);
dist_estacionaria = [dist_estacionaria(1:N)' dist_estacionaria(N+1:end)'];

figure(3)
plot(a_grid, sum(dist_estacionaria, 2), 'LineWidth', 1.5);
title('Distribuição estacionária');
xlabel('Ativos (a)');
ylabel('Probabilidade');
grid on;

B = -sum(sum(dist_estacionaria .* G_pos));
disp(['Soma das distribuições estacionarias da função politica: ', num2str(B)]);

