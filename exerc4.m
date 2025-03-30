clc; clear; close all;


A=1;
T=A*2;
syms f(t)

f(t) = piecewise(mod(t,T) <= T/2, A, 0);
t_k= linspace(0, 3*T, 1000);

plot(t_k,f(t_k),'b-',"LineWidth",2);
xlabel("Tempo (t)")
ylabel("f(t) (azul) versus x(t) (vermelho)")
hold on;


syms x(t) k 

% Replaced k with 2*k - 1 to get only odd numbers
% k = 1 , 2*1 - 1 = 1
% k = 2, 2*2 - 1 = 3
% and so on.
x(t) = A/2 + (A/(pi))* symsum((2*sin((2*pi*(2*k - 1)*t)/T))/(2*k - 1),k, 1, 100);

plot(t_k,x(t_k),'r','LineWidth', 2);


% Now calculating |X(fk)|

syms X(fk) f(k) abs_X(fk)

f(k) = k/T;
X(k) = A/(1i*pi*k);

figure;
k_values = [-50:50];

abs_X(fk) = piecewise(fk == 0, A/2, abs(X(fk)));

stem(f(k_values), abs_X(k_values), 'b', "filled", 'LineWidth', 2);
xlabel('f');
ylabel('|X(fk)|');
title('Plot of absolute value of X(fk)');




%{
% Parameters
A = 1;          % Amplitude
T = 2*pi;       % Period (adjust as needed)
K = 100;        % Number of odd harmonics (higher = better approximation)
t = linspace(0, 3*T, 1000);  % Time vector (3 periods for visualization)

% Initialize the sum
lambda = zeros(size(t));

% Sum over odd harmonics (k = 1, 3, 5, ..., K)
for k = 1:2:K  
    lambda = lambda + (2/k) .* sin(2*pi*k*t/T);
end
lambda = A/2 +  (A/pi) * lambda;  % Scale by A/(iπ)

% Plot the real part (or magnitude for complex values)
figure;
plot(t, real(lambda), 'LineWidth', 1.5);  % Use real() or abs() as needed
xlabel('Time (t)');
ylabel('Amplitude');
title('Fourier Series: Square Wave Approximation (Odd Harmonics)');
grid on;
%}