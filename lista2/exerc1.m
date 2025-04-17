clc; clear; close all; 



syms X(k) X_k(k)
error_array = [];
limit = 32;
counter=1;
N = 8; % number of points
while N <= limit
    n=0:N-1;
    
    % Find Discrete Fourier Transform and normalize by N
    % that is, divide by N.
    X(k) = sum(exp(-n*(1+1i*2*pi*k)/N)/N);
    
    % Find the coefficientes Xk of the Fourier Series
    X_k(k) = (1 - exp(-1))/(1+ 1i*2*pi*k);
    

    % Plot the graphs
    figure;
    
    
    n_shift=-N/2:N/2-1;
    Dft_shift = fftshift(X(n));
    stem(n_shift,abs((Dft_shift)),'b', 'LineWidth', 2);
    ylabel("abs(Xk or DFT(x))");
    xlabel("k");
    hold on;
    
    stem(n_shift,abs(X_k(n_shift)),'r', 'LineWidth', 2);
    %stem(n_shift,real(X_k(n)),"filled", 'LineWidth', 2);
    my_legend = sprintf("DFT with %d points",N);
    legend(my_legend,"Fourier Series");


    N = N * 2;
    error = sum((real(X_k(n) - X(n))).^2)/N;
    error_array = [error_array;error];
end

figure;
title("Mean squared error");
hold on;
xlim([-3,3]);

bar(0,error_array(1,:));
bar(1,error_array(2,:));
bar(-1,error_array(3,:));
legend("8 points", "16 points", "32 points");
hold off;
