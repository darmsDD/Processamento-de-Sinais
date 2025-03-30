clc; clear; close all;

A = 1;
T = 4*A;

syms f(t)

f(t) = piecewise(mod(t,T) <= T/4, A, 0);
t_k = linspace(0,3*T,500);

plot(t_k,f(t_k),"b-.", "Linewidth", 2);
xlabel("Tempo (t)")
ylabel("f(t) (azul) versus x(t) (vermelho)")
hold on;
syms x_approx1(t) x_approx2(t) x_approx3(t) x_approx(t) X(k)

Xk_0 = A/4;

syms b(k) a(k) k
%por trigonométrica
a0 = 2 * Xk_0;
a(k) = sin(pi*k/2);
b(k) = 1- cos(pi*k/2);
x_approx(t) = a0/2 + ((A/pi)*symsum((a(k)*cos(k*2*pi*t/T) + b(k)*sin(k*2*pi*t/T))/k,k,1,Inf));
x_vals = vpa(real(x_approx(t_k)));
plot(t_k, x_vals,"ro","Linewidth",2); % sobra algum resíduo imaginário devido a computação


%usando a resposta por exponencial para calcular |Xk|
syms abs_X(k) f(k)
f(k) = k/T;
X(k) = A*(a(k) - 1i*b(k))/(2*pi*k);
abs_X(k) = piecewise(k == 0, Xk_0, abs(X(k)));

k_values = [-50:50];

figure;
stem(f(k_values), abs_X(k_values), 'b', "filled", 'LineWidth', 2);
xlabel('f');
ylabel('|X(fk)|');
title('Plot of absolute value of X(fk)');
%{
2 métodos por exponcial

1- Método
X(k) = (A / (pi * k)) * sin(pi * k / 4) * exp(-1i * pi * k / 4);  % Alternative form %((-1i*A)/(2*pi*k))*(1 - exp(-1i*pi*k/2));
x_approx1(t) = symsum(X(k) * exp(2i * pi * k * t / T), k, -Inf, -1);
x_approx2(t) = symsum(X(k) * exp(2i * pi * k * t / T), k, 1, Inf);
x_approx(t) = Xk_0 + (x_approx1(t) + x_approx2(t));
%}

%{

2- método
S = [-1:-4:-100, 1:4:100];
R = [-2:-4:-100, 2:4:100];
L = [-3:-4:-100, 3:4:100];
%X(k) = 1/k;
Xk_0 = A/4;
x_approx1(t) = ((1+1i)/2)*sum(subs(X(k) * exp(2i * pi * k * t / T), k, S));
x_approx2(t) = sum(subs(X(k) * exp(2i * pi * k * t / T), k, R));
x_approx3(t) = ((1-1i)/2)*sum(subs(X(k) * exp(2i * pi * k * t / T), k, L));
x_approx(t) = A/4 + (A/(1i*pi))*(x_approx1(t) + x_approx2(t) + x_approx3(t));
%}