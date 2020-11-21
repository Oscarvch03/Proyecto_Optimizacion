% Fase I Método Simplex

function [Base, No_Base] = Fase_I(c, A, b, verbose)
    % Input: c: es el vector fila de costos.
    %        A: es la matriz asociada a las restricciones.
    %        b: es el vector columna de los terminos de la derecha de las
    %           restricciones.
    
    % Output: Base: Base que genera una solucion basica factible
    %         No_Base: Variables que no pertenecen a la base
    
    
    sz_A = size(A);
    ident = eye(sz_A(1));
    A_aux = [A, ident]; % Añadimos las variables artificiales
    
    vars = 1:1:sz_A(2);
    
    I_B = []; % Historial de variables basicas
    I_N = []; % Historial de variables no basicas
    
    i_b = (sz_A(2) + 1):1:(sz_A(2) + sz_A(1));
%     disp("Base inicial.");
%     I_B = [I_B; i_b];
    
    c_aux = zeros(1, length(c) + length(i_b));
    c_aux(i_b) = 1;
    
    i_n = 1:1:sz_A(2);
%     I_N = [I_N; i_n];
    
    if(verbose)
        fprintf("\n")
        disp("FASE 1:")
        fprintf("\n\n")
    end
    
    it = 1;
    while(true)
        %% Iteracion, Paso 1
        
        I_B = [I_B; i_b];
        I_N = [I_N; i_n];
    
        B = A_aux(:, i_b);
        N = A_aux(:, i_n);
        X_B = inv(B) * b;

        z0 = c_aux(i_b) * X_B;
        
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

        C_N = c_aux(i_n) - c_aux(i_b) * inv(B) * N;
        
        if(verbose)
            disp("Iteracion: " + num2str(it) + ", Paso 2")
            fprintf("\n")
            disp("C_N = ")
            disp(C_N)
        end
        
        cond = C_N >= 0;
        if(length(C_N) == sum(cond)) % Verificar costos reducidos >= 0
            cond2 = i_b < (sz_A(2) + 1);
            if(length(i_b) == sum(cond2)) % Verificar que en la base no tenga variables artificiales
                Base = sort(i_b);
                in = ismember(vars, i_b);
                No_Base = [];
                l = 1;
                for i = 1:length(in)
                    if(in(i) == 0)
                        No_Base(l) = i;
                        l = l + 1;
                    end
                end
            else
                Base = []; % El problema no tiene solucion factible, la region no es convexa
                No_Base = [];
            end
            break;
        else
%             disp("Cambiar de base. ");
        end

        %% Iteracion, Paso 3

        [n, j]  = min(C_N);
        a_j = A_aux(:, j);
        y_j = inv(B) * a_j;
        x_aux = [];
        for i = 1:length(y_j) % Mismo tamaño de X_B
            if(y_j(i) > 0 && X_B(i) / y_j(i) >= 0)
                x_aux = [x_aux, X_B(i) / y_j(i)];
            else
                x_aux = [x_aux, Inf];
            end
        end
        
        [x_j, k] = min(x_aux);
        
        entra = i_n(j); % Entra a la base
        sale = i_b(k); % Sale de la base
        
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
    
%     X = zeros(sz_A(2), 1);
%     X(i_b) = X_B';
      
end