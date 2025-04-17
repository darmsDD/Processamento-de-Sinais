clc; close all; clear;

% Letra a, cálculo da DFT

x = [1 0 -1 0];
N = length(x)
DFT = 0;
for n=0:N-1
    DFT = DFT + x(n+1)*exp(-1i*2*pi*n/N);
end
disp("My dft");
disp(DFT);

disp("FFT");
disp(fft(x));

