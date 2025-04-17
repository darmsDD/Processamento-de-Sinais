clc; clear; close all;

error_array = [];
limit = 32;
N = 8;

while N <= limit
    n = 0:N-1; % tempo discreto
    k = -N/2:N/2-1; % índices da série de Fourier

    % Definição do sinal
    x = exp(-n); % sinal no tempo discreto
    %x = x(:); % garante coluna

    % Calcula a DFT e normaliza
    X = fft(x); % DFT
    X = X / N;  % normalização para comparar com X_k
    X = fftshift(X); % reorganiza frequências para -N/2:N/2-1

    % Calcula X_k da série de Fourier
    X_k = 1 ./ (1 + 1i*2*pi*k); % vetor com valores X_k

    % Plot
    figure;
    stem(k, abs(X), 'b', 'LineWidth', 2); hold on;
    stem(k, abs(X_k), 'r--', 'LineWidth', 2);
    legend(sprintf("DFT com %d pontos", N), "Série de Fourier");
    xlabel('k');
    ylabel('Re{X_k}');
    title(sprintf("Comparação DFT vs Série de Fourier (%d pontos)", N));

    % Erro médio quadrático
    err = mean(abs(X - X_k).^2);
    error_array = [error_array; err];

    % Avança para o próximo N
    N = N * 2;
end

% Plota o erro
figure;
bar([8,16,32], error_array);
xlabel("N (número de pontos)");
ylabel("Erro quadrático médio");
title("Erro DFT vs Série de Fourier");
