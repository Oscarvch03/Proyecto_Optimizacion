function [xs, vb, vnb, flag, iter] = fase2(A, b, c, xs, flag, vb, vnb)

    % fase 2 del simplex para determinar una solución para Min ct*x sa Ax=b

    % fprintf('ya entro a fase dos:') 

    [m, n] = size(A); % dimensiones de A

    % fprintf('nuevas variables basicas') 
    vb = vb(find(vb <= n));
    vnb = vnb(find(vnb <= n));

    iter = 0;

    % Revisar si el problema es no vacío 
    if (flag < 0)
        % disp('EL conjunto factible es vacio')
        return
    end

    % Modificar el problema para tener b(i) > 0 para toda i
    for i = 1:m
        if b(i) < 0
            A(i,:) = -A(i, :);
            b(i) = -b(i); 
        end
    end

    % Variables extras
    flag = -1;
    itermax = 100000;

    % Hacer el simplex tantas veces como sea necesario con tope máximo
    while (flag < 0 && iter <= itermax)
        [A, c, b, xs, vb, vnb, flag] = itersimplexbland(A, c, b, xs, vb, vnb, flag);
        iter = iter + 1; % obtener el número de iteraciones en esta fase
    end

    % Revisar si el problema es no acotado inferiormente
    if(flag == 0)
        % disp('El conjunto es no acotado inferiormente')
        return
    end

end