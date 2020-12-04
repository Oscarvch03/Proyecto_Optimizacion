% Solucion Problema de Programacion No Lineal

clc

syms x1 x2 x3 x4 x5 x6

a = 0.0005;
mu = 100;
X = 835;

exps = 5 * (x1 * exp(-a * x1) + x2 * exp(-a * x2) + x3 * exp(-a * x1) + x4 * exp(-a * x4) + x5 * exp(-a * x5) + x6 * exp(-a * x6)) + 30 * 6; 
logs = log(x1 + 1) + log(x2 + 1) + log(x3 + 1) + log(x4 + 1) + log(x5 + 1) + log(x6 + 1);
f = exps + logs; 

h1 = x1 + x2 + x3 + x4 + x5 + x6 - X;
h2 = x1 - (1/2) * x2 - (1/2) * x5;
h3 = x2 - x3 - x6;
h4 = (1/2) * x3 + (1/2) * x5 - x4;
P = f + mu * (h1 ^ 2 + h2 ^ 2 + h3 ^ 2 + h4 ^ 2); 

pretty(P)
disp("-------------------------------------------------------")

X0 = [X/6, X/6, X/6, X/6, X/6, X/6];
Xf = Descenso_Gradiente(P, X0, 0.001, 50)

disp("El valor de la función objetivo es: ")
double(subs(f, [x1, x2, x3, x4, x5, x6], [Xf(1), Xf(2), Xf(3), Xf(4), Xf(5), Xf(6)])) * 1000
