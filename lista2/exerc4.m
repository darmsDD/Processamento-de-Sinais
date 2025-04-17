clc; clear; close all;

x_vector = [0,1,0,-1,0,1,0,-1]; %cases 2 and 4 only have 2 points
DeltaT = 1;
fa = 1/DeltaT; % 
sample_size = length(x_vector);

N_1_to_4 = [8,6];
Number_of_cases = length(N_1_to_4);

% Discrete fourier
% X(k) = sum_{n=0}^_{N-1} x(n) e^{-j2pikn/N}, k = {0,1,2,..., N-1}

X_dft = zeros(Number_of_cases,sample_size);
for i=1:Number_of_cases
    N = N_1_to_4(i); 
    for k=0:N-1
        for n=0:N-1
            X_dft(i,k+1) = X_dft(i,k+1) + x_vector(n+1) * exp(-1i*2*pi*k*n/N); 
        end
    end
end

disp("My dft:");
disp(X_dft);
disp('MATLAB fft with 8 samples:');
disp(fft(x_vector));
disp('MATLAB fft with 6 samples:');
disp(fft(x_vector(:,1:end-2)));


max_frequency = zeros(1,Number_of_cases);
for i=1:Number_of_cases
    N = N_1_to_4(i);
    % f = k*fa/N, k = {0,1,2,..., N-1}. 
    % So to get the maximum frequency k = N-1
    max_frequency(i) = (N-1)*fa/N;
end
disp("Max frequencies:");
disp(max_frequency);








