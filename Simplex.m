% Integrantes:
% Juan Camilo Rodriguez
% Oscar Velasco
% 30/08/2020


function X = Simplex(c, A, b, flag, verbose)
    % Este algoritmo admite problemas de min y max dependiendo de flag
    % Si verbose es true, se imprime el procedimiento del algoritmo
    % Solucion a problemas de programacion lineal en formato estandar
    % Input: c: es el vector de costos
    %        A: es la matriz de coeficientes de las restricciones
    %        b: es el lado derecho de las restricciones
    
    if(verbose)
        fprintf("\n")
        disp("Problema de " + flag + ":")
        fprintf("\n")
        disp("c = ");
        disp(c)
        disp("A = ");
        disp(A)
        disp("b = ");
        disp(b)
    end
    
    if(flag == "max")
        c = -1 .* c;
        if(verbose)
            disp("Para min:  c = ")
            disp(c)
        end
    end
    
    sz_A = size(A);
    if(length(c) == sz_A(2) && sz_A(1) == length(b))
        
        % fprintf("Los parametros SI coinciden.\n\n");
        
        [Base_ini, No_Base_ini] = Fase_I(c, A, b, verbose);
        
        if(isempty(Base_ini))
            X = "El problema no tiene region factible, la región no es convexa.";
        else
            if(verbose)
                disp("Base Inicial:")
                disp(Base_ini)
            end
            X = Fase_II(c, A, b, Base_ini, No_Base_ini, verbose);
            if(isempty(X))
                X = "El problema no tiene optimo finito.";
            end
        end
        
    else
        X = "Los parametros NO coinciden.\n\n";
    end
    
    Sol = X;
    
end