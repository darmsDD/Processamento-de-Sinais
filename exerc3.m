clc; clear; close all;

syms f(t)
f(t) = exp(2*cos(t))*cos(2*sin(t));
t_k = 0:0.1:50;

figure;
plot(t_k,f(t_k))
xlabel("Tempo")
ylabel("f(t) e x(t)")
hold on;

% Agora por série de fourier

syms x(t) n
x(t) = 1 + symsum((2*cos(n*t))/factorial(n),n,1,Inf);
plot(t_k,x(t_k), 'ro','LineWidth', 2);