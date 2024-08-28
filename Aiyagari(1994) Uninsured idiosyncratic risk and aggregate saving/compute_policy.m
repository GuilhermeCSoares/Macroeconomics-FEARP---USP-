function [V,gk] = compute_policy(beta, gamma, n_grid, k_grid, Pi, N, M, V, r, w)
    util = @(c)(c.^(1-gamma))./(1 - gamma);

    TV   = V; %Função valor temporaria
    gk   = V; %Função politica

    dist = 10;  %distancia
    itmax = 2000; %maximo de iterações
    tol  = 1e-5; % tolerancia
    it   = 0; 
    
    while dist > tol && it< itmax
        it = it + 1;
        for i=1:M
            for j=1:N
                c = (w * n_grid(i) + (1+r)*k_grid(j) - k_grid').*(w * n_grid(i) + (1+r)*k_grid(j) - k_grid' >0) + eps.*(w * n_grid(i) + (1+r)*k_grid(j) - k_grid' <=0);
                value = util(c)  + beta * V  * Pi(i,:)';
                [TV(j, i), pol] = max(value);   
                gk(j,i) = k_grid(pol);               
                
            end
        end   
        dist = max(max(abs(TV - V)));
        V = TV;
    end

% Verificar se a convergência foi atingida
    if dist <= tol
        fprintf('Tolerância atingida! Distância final: %.10f\n', dist);
    else
        fprintf('Limite de iterações atingido. Distância final: %.10f\n', dist);
    end
    
    fprintf('Número total de iterações: %.0f\n', it);
end