clear;
clc;

% Parameters
b = 1;
a1 = 1;
a2 = 3;
a3 = 1;
K0 = tf([b],[1 a1 a2 a3]);
pole(K0)

% PID Parameters
k = 1.0;
Ti = .9;
Td = 1;
P = k;
I = tf([1],[Ti 0]);
D = tf([Td 0],[1]);

% PID regulator
PID_reg = P*(1+I+D);
PI_reg = P*(1+I);
P_reg = P;

% Main path
main = PID_reg * K0;

% Transfer function
G = feedback(main, 1)
step(G)
title('Ti = 0.9, k = 1')
