% Fase II Método Simplex

function X = Fase_II(c, A, b, Base_ini, No_Base_ini, verbose)
    % Input: c: es el vector fila de costos.
    %        A: es la matriz asociada a las restricciones.
    %        b: es el vector columna de los terminos de la derecha de las
    %           restricciones.
    %        Base: Base que genera una solucion basica factible
    %        No_Base: Variables que no pertenecen a la base
    
    % Output: X: Solucion Optima de cada variable para el problema
    
    if(verbose)
        fprintf("\n")
        disp("FASE 2:")
        fprintf("\n\n")
    end

    sz_A = size(A);
    
    I_B = []; % Historial de variables basicas
    I_N = []; % Historial de variables no basicas
    
    i_b = Base_ini;
    i_n = No_Base_ini;
    
    it = 1;
    while(true)
        %% Iteracion, Paso 1
            
        I_B = [I_B; i_b];
        I_N = [I_N; i_n];
        
        B = A(:, i_b);
        N = A(:, i_n);
        X_B = inv(B) * b;
        
        z0 = c(i_b) * X_B; 
        
        if(verbose)
            disp("Iteracion: " + num2str(it) + ", Paso 1")
            fprintf("\n")
            disp("I_B = ")
            disp(i_b)
            disp("I_N = ")
            disp(i_n)
            disp("X_B = ")
            disp(X_B)
            disp("Z_0 = " + num2str(z0))
            fprintf("\n")
        end
        
        %% Iteracion, Paso 2
        
        
        C_N = c(i_n) - c(i_b) * inv(B) * N;
        
        if(verbose)
            disp("Iteracion: " + num2str(it) + ", Paso 2")
            fprintf("\n")
            disp("C_N = ")
            disp(C_N)
        end
        
        C_0 = 0;
        C_N_aux = ismember(C_0, C_N);
        if(sum(C_N_aux) ~= 0 && verbose)
            disp("Hay multiples soluciones optimas.")
            fprintf("\n")
        end
        
        
        cond = C_N >= 0;
        if(length(C_N) == sum(cond)) % Verificar costos reducidos >= 0
            X = zeros(sz_A(2), 1);
            % Verificar si se presenta una solucion degenenerada 
            X_0 = 0;
            X_aux = ismember(X_0, X_B');
            if(sum(X_aux) ~= 0)
                disp("Se presenta una solución degenerada.")
                fprintf("\n")
            end
            X(i_b) = X_B';
%             disp("I_B = ")
%             disp(sort(i_b))
            break;
        end
        
        %% Iteracion, Paso 3
        
        [n, j]  = min(C_N);
        a_j = A(:, j);
        y_j = inv(B) * a_j;
        
        
        % Evitar Ciclaje en los costos
        l = 1;
        C_N_rep = [];
        C_N_var = [];
        for k = 1:length(C_N)
            if(C_N(k) == n)
                C_N_rep(l) = k;
                C_N_var(k) = i_n(k);
            end
        end
        [m1, p1] = min(C_N_var); % Criterio de orden Lexicografico
        entra = i_n(p1);  % Entra a la base
        
        
        % Si y_j <= 0 entonces el problema no tiene optimo finito
        y_j_aux = y_j <= 0;
        if(length(y_j) == sum(y_j_aux))
            X = [];
            break;
        end
        
        
        x_aux = [];
        for i = 1:length(y_j) % Mismo tamaño de X_B
            if(y_j(i) > 0 && X_B(i) / y_j(i) >= 0)
                x_aux = [x_aux, X_B(i) / y_j(i)];
            else
                x_aux = [x_aux, Inf];
            end
        end
        [x_j, q] = min(x_aux);
        
        
        % Evitar Ciclaje en los X_k
        o = 1;
        X_k_rep = [];
        X_k_var = [];
        for k = 1:length(x_aux)
            if(x_aux(k) == x_j)
                X_k_rep(o) = k;
                X_k_var(k) = i_b(k);
            end
        end
        [m2, p2] = min(C_N_var); % Criterio de orden Lexicografico
        sale = i_b(p2); % Sale de la base
        
        if(verbose)
            disp("Iteracion: " + num2str(it) + ", Paso 3")
            fprintf("\n")
            disp("Entra a la base X" + num2str(entra))
            disp("Sale de la base X" + num2str(sale))
            fprintf("\n")
        end
        
        % Respetar el orden de i_b e i_n
        for i = 1:length(i_b)
            if(i_b(i) == sale)
                i_b(i) = entra;
                break;
            end
        end
        for i = 1:length(i_n)
            if(i_n(i) == entra)
                i_n(i) = sale;
                break;
            end
        end
       
    it = it + 1;    
        
    end

end