clc

c = [14400, 11800, 16400, 10000, 9250, 11700, 0, 0, 0, 0, 0, 0, 0, 0];
A = [12000, 8000, 10000, 12000, 10000, 7000, 1, 0, 0, 0, 0, 0, 0, 0;
     1, 1, 1, 1, 1, 1, 0, -1, 0, 0, 0, 0, 0, 0;
     1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0;
     0, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0;
     0, 0, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0;
     0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0;
     0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, -1, 0;
     0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, -1];
b = [7000000; 735; 100; 110; 60; 80; 120; 90];

X = Simplex(c, A, b, "max", true) % Se queda en ciclaje x1 y x7