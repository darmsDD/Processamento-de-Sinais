clc; clear; close all;



A = 1;
T = 4*A;
syms f(t) u(t)
u(t) = piecewise(t >=0, A,0);

f(t) = u(t) - u(t - T/4);

t_k = linspace(0,2*T,1000);


plot(t_k,f(t_k),"b","Linewidth",2);
xlabel("Tempo (t)");
ylabel("f(t) = µ(t) - µ(t-T/4)");
hold on;

% Writing |X(f)|

syms X(f) abs_X(f)

X(f) = A*sin(pi/4)*exp(-1i*pi/4)/(pi*f);

fk_values = [-10:1/T:-1, 1:1/T:10];

figure;
plot(fk_values,abs(X(fk_values)),"r:","Linewidth",5);
xlabel("Frequência (f)");
ylabel("|X(f)|");
