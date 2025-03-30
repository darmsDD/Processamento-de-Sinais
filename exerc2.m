clc; clear; close all;
syms f(t)

f(t) = exp(t);

t_k = 0:0.1:2*pi;

plot(t_k,f(t_k),'r-', 'LineWidth', 2); % Plot the f(t) function

syms x_approx_pinf(t) x_approx_ninf(t) x_approx(t) k

x_approx_pinf(t) = symsum(((exp(2*pi) - 1)*exp(1i*k*t))/((1-1i*k)),k, 1,Inf);
x_approx_ninf(t) = symsum(((exp(2*pi) - 1)*exp(1i*k*t))/((1-1i*k)),k, -Inf,-1);
x_approx_zero(t) = ((exp(2*pi) - 1)*exp(1i*0*t))/((1-1i*0));
x_approx(t) = (1/(2*pi))*(x_approx_pinf(t) + x_approx_ninf(t) + x_approx_zero(t));

hold on
xlabel('t');
ylabel('f(t)');
title('Plot of f(t) = exp(x)');
grid on;

%x_apr = eval(x_approx(t_k));
plot(t_k,x_approx(t_k),'bo', 'LineWidth', 2); % plot the x(t) approximation using fourier seriers

figure;
syms  T X(fk) f(k,T)
f(k,T) = k/T;
X(fk) = (exp(2*pi) - 1)/((2*pi)*sqrt(1+fk^2));%(exp(2*pi) - 1)/((2*pi)*(1-1i*fk));
%f(k) = k/T;
T_value = 2*pi;
k_values = [-50:50];

stem(f(k_values,T_value), abs(X(k_values)), 'b', "filled", 'LineWidth', 2); % Barras verticais
xlabel('f');
ylabel('|X(fk)|');
title('Plot of absolute value of X(fk)');