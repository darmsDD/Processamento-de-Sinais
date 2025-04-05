clc; clear; close all;

% Define f(t)

syms f(t)


A=3;
T=7;
f(t) = mod(t,T)*A/T;
t_values = linspace(-2*T,2*T,1000);

% Find Xk approximation

syms X_approx(k) x_in_period(t)

N = 10000;  % Number of sample points in one period
k_range = -1000:1000;  % All k values we want to compute
% Time samples
n = (0:N-1)';
t_n = n*T/N;
x_n = A*t_n/T;

% Precompute the Fourier matrix
exp_matrix = exp(-1i*2*pi/N * k_range .* n);

% Vectorized computation of all X_k
X_k = (x_n' * exp_matrix)/N;

% Find Xk

syms X(k)

X(k) = A*1i/(2*pi*k);
Xk_0 = A/2;

% Find x(t) by Xk approximation

x_reconstructed = zeros(size(t_values));
for idx = 1:length(t_values)
    t = t_values(idx);
    x_reconstructed(idx) = sum(X_k .* exp(1i * 2 * pi * k_range * t / T));
end

% Find x(t) by Xk

syms x_by_Xk(t) 

x_by_Xk(t) = Xk_0 + symsum(X(k)*exp(1i*2*pi*k*t/T),k, 1, Inf) + symsum(X(k)*exp(1i*2*pi*k*t/T),k, -Inf, -1);


plot(t_values, f(t_values), 'r',"Linewidth",2);  % Original samples
hold on;
plot(t_values,vpa(real(x_by_Xk(t_values))),"mo","Linewidth",2);
hold on;
plot(t_values, real(x_reconstructed), 'b:', 'LineWidth', 2);
legend('Original Samples','Reconstructed by Xk','Reconstructed by Xk approximation');

figure;
k_values = [-50:50];
abs_X(k) = piecewise(k == 0, Xk_0, abs(X(k)));

normalized_freq = k_values / T;
stem(normalized_freq,abs_X(k_values),'b', "filled", 'LineWidth', 2);
hold on;
% Find indices of k_subset in k_range_full
start_idx = find(k_range == -50, 1);
end_idx   = find(k_range ==  50, 1);

% Extract subset of X_k
X_k_subset = X_k(start_idx:end_idx);
stem(normalized_freq, abs(X_k_subset), 'r'); 
legend('|Xk|','|Xk approximation|');



