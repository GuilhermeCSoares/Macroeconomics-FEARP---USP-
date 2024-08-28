function stationary_dist = compute_invariant_dist(gk, Pi, N, k_grid)
    A1 = zeros(N, N); 
    A2 = zeros(N, N);
    A3 = zeros(N, N);

    % Preencher as matrizes A1, A2 e A3 com as políticas ótimas
    for i = 1:N
        for j = 1:N
            A1(i, j) = gk(i, 1) == k_grid(j);
            A2(i, j) = gk(i, 2) == k_grid(j);
            A3(i, j) = gk(i, 3) == k_grid(j);
        end
    end

    % Construir a matriz SS combinando as probabilidades de transição de Pi
    SS = [Pi(1,1) * A1, Pi(1,2) * A2, Pi(1,3) * A3;
          Pi(2,1) * A1, Pi(2,2) * A2, Pi(2,3) * A3;
          Pi(3,1) * A1, Pi(3,2) * A2, Pi(3,3) * A3];

    % Elevar SS a uma potência alta para encontrar a distribuição invariante
    stationary_dist = SS^1000;
    stationary_dist = stationary_dist(1, :); % Pegar a primeira linha da distribuição
    stationary_dist = [stationary_dist(1:N)' , stationary_dist(N+1:2*N)', stationary_dist(2*N+1:end)'];
end