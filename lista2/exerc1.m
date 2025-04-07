clc; clear; close all; 

N=128;
n=0:N-1;

syms X(k)

X(k) = sum(exp(-n*(1+1i*2*pi*k)/N)/N);

stem(n,real(X(n)),'b', 'LineWidth', 2);

syms X_k(k)

X_k(k) = (1 - exp(-1))/(1+ 1i*2*pi*k);
hold on;
stem(n,real(X_k(n)),'r', 'LineWidth', 2);



