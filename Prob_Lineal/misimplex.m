function [xf, iter1, iter2, flag] = misimplex(A, c, b)

    % Resuelve por el metodo Simplex el problema estándar
    %     Min      c'*x
    % Sujeto a    A*x = b
    %               x >= 0

    [m, n] = size(A); % dimensiones de A
    xf = [];
    iter = 0; %Declara el número de iteraciónes en 0

    % FASE 1
    [xs, vb, vnb, flag, iter1] = fase1(A, b); %Llama a la fase 1
    %la xs que sale es de (n+m)x1

    % FASE 2
    [xf, vb, vnb, flag, iter2] = fase2(A, b, c, xs, flag, vb, vnb); %Llama a la fase 2
    iter = iter1 + iter2; % Calcula el número de iteraciones totales por fase 1 y 2

    % Imprimir resultados si hay solución
    if(flag > 0)
        fprintf('El valor de la función objetivo es:') 
        c' * xf(1:n)
    end 

end