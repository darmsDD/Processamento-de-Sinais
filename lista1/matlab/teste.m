clc; clear; close all;

% Parameters


syms f(t)


A=3;
T=7;
f(t) = mod(t,T)*A/T;
t_values = linspace(-2*T,2*T,1000);
N = 10000;  % Number of sample points in one period
k_range = -1000:1000;  % All k values we want to compute

% Time samples
n = (0:N-1)';
t_n = n*T/N;

% Signal samples (sawtooth wave)
x_n = A*t_n/T;

% Precompute the Fourier matrix
exp_matrix = exp(-1i*2*pi/N * k_range .* n);

% Vectorized computation of all X_k
X_k = (x_n' * exp_matrix)/N;

% 2. Reconstruct x(t)
x_reconstructed = zeros(size(t_values));
for idx = 1:length(t_values)
    t = t_values(idx);
    x_reconstructed(idx) = sum(X_k .* exp(1i * 2 * pi * k_range * t / T));
end

% 3. Plot
figure;
plot(t_values, real(x_reconstructed), 'b', 'LineWidth', 2);
hold on;
plot(t_values, f(t_values), 'r');  % Original samples
legend('Reconstructed', 'Original Samples');


% X_k now contains all coefficients for k in k_range