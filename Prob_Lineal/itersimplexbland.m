function [A, c, b, xs, vb, vnb, flag] = itersimplexbland(A, c, b, xs, vb, vnb, flag)
    % Una iteración del método Simplex para el problema de forma estándar

    [m,n] = size(A);      % dimensión del problema
    B = A(:,vb);          % columnas básicas
    cB = c(vb);           % vector básico
   
    % Cálculo de los costos reducidos
    vpi = (B') \ (cB);            % Sistema lineal ; B'*vpi = cB
    cbar = zeros(n - m, 1);
    for j = 1:(n - m)
        cbar(j) = c(vnb(j)) - vpi' * A(:, vnb(j));  % costo reducido
    end

    [cbarmin, qq] = mymin(cbar);  % Regla de Bland *primer índice*
    q = vnb(qq);                  % índice donde ocurre el menor costo reducido 
    %cbarmin                     % menor costo reducido

    if (cbarmin < 0)
         % Se calcula la arista o una dirección para moverse
         w = B \ A(:, q);      % vector arista y vector dirección
         test = sum(w > 0);    % en busca de componentes positivas en w
         if (test > 0)
             [wp,ind] = compositivas(w);   % componentes positivas de w
             vtheta = xs(vb(ind)) ./ wp;   % movimientos
             [theta, jj] = min(vtheta);    % menor movimiento
             p = vb(ind(jj));              % variable básica que saldrá
             
             %Actualizamos valores
             xs(vb) = xs(vb) - theta * w;    % movimiento de las variables básicas
             xs(q) = theta;                  % nueva coordenada básica. 
             vb(ind(jj)) = q;                % variable básica que entra
             vnb(qq) = p;                    % variable que cambia a no básica
             vb = sort(vb);                  % ordenar los básicos
             vnb = sort(vnb);                % ordenar los indices básicos
         else
             % disp(' SE ENCONTRÓ UNA DIRECCIÓN')
             flag = 0;
             return % Para regresar en caso de que el problema sea no acotado
         end
    else
        flag = 1; % Se encontro que el problema tiene solución
    end
    
end