function [w,vb,vnb,flag, iter] = fase1(A,b)
    
    % fase 1 del simplex para determinar un vértice para Min ct*x sa Ax=b
    [m,n] = size(A); % dimensiones de A

    % Modificar el problema para tener b(i) > 0 para toda i
    for i = 1:m
        if b(i) < 0
            A(i,:) = -A(i,:);
            b(i) = -b(i);
        end
    end

    %Variables para el problema auxiliar
    w = [zeros(1, n), b']';            %vértice w=(x,y)=(0n,b) de (n+m)xb
    Aa = [A eye(m)];                   %matriz con rango m del problema auxiliar
    e = ones(m, 1);                    % vector de unos en m*1
    zt = [-(e' * A), zeros(m, 1)']';   % z función objetivo del problema auxiliar
    vb = [n + 1:n + m]';               %encuentra las variables basicas de w
    vnb = [1:n]';                      %encuentra las variables no basicas de w
    ba = b';

    % Variables extras
    flag = -1;
    iter = 0;
    itermax = 100000;

    % Hacer el simplex tantas veces como sea necesario con tope máximo
    while (flag < 0 && iter <= itermax)
        iter = iter + 1; % Obtener el número de iteraciones en esta fase 
        [Aa, zt, ba, w, vb, vnb, flag] = itersimplexbland(Aa, zt, ba, w, vb, vnb, flag);
    end

    %VERIFICAR SI EL CONJUNTO ES VACÍO
    % Revisamos si es no vacío el conjunto factible del problema original, 
    % utilizando la fobj del problema auxiliar. 
    if(e'* ba' - e'*A*w(1:n) ~= 0)
        flag = -1;
    end

end