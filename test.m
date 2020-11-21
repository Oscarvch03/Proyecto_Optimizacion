clc

%% Solucion Optima Finita
% min
c1 = [5, -1, 0, 0];
A1 = [-1, 2, -1, 0; 1, 1, 0, 1];
b1 = [2; 6];

X1 = Simplex(c1, A1, b1, "min", false)

%% No hay region factible o convexa
% min
c2 = [5, -1, 0, 0];
A2 = [-1, 2, 1, 0; -1, 1, 0, -1];
b2 = [2; 3];

X2 = Simplex(c2, A2, b2, "min", false)

%% Solucion Optima Finita
% min
c3 = [2, -3, 0, 0];
A3 = [1, 1, 1, 0; 0, 1, 0, 1];
b3 = [6; 3];

X3 = Simplex(c3, A3, b3, "min", false)

%% Multiples soluciones
% min
c4 = [-2, -4, 0, 0];
A4 = [1, 2, 1, 0; -1, 1, 0, 1];
b4 = [4; 1];

X4 = Simplex(c4, A4, b4, "min", false)

%% Ciclaje
% max
c5 = [-3, 9, 0, 0];
A5 = [1, 4, 1, 0; 1, 2, 0, 1];
b5 = [8; 4];

X5 = Simplex(c5, A5, b5, "max", false)

%% No hay Optimo Finito
% max
c6 = [-3/4, 20, -1/2, 6, 0, 0, 0];
A6 = [1/4, -8, -1, 9, 1, 0, 0; 
      1/2, -12, -1/2, 3, 0, 1, 0; 
      0, 0, 1, 0, 0, 0, 1];
b6 = [0; 0; 1];

X6 = Simplex(c6, A6, b6, "max", true)


