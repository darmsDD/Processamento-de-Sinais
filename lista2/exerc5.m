clc; close all; clear;

x = [1 0 -1 0];

N = length(x);
my_DFT = zeros(1,N);

for k=1:N
    for n=1:N
        my_DFT(k) = my_DFT(k) + x(n) * exp(-1i*2*pi*(k-1)*(n-1)/N);
    end
end

disp("MY dft");
disp(real(my_DFT));
disp("Fft");
disp(fft(x));

% Remember that in DFT, half of the points are the negative frequencies
% odd: {1,2,3,4,5} => fftshift {4,5,1,2,3}. With 1 being the 0 point
% even: {1,2,3,4} => fftshift {3,4,1,2}. With 1 being the 0 point.

my_DFT2 = real(fftshift(my_DFT));

fa = 1000;
deltaF = fa/N;

mid_index = floor((N + 1)/2);
k_values_with_negative = -mid_index:mid_index-1;
k_values = 1:N;
ylabel("Dft(x)");
xlabel("Frequency (Hz)");
stem(k_values_with_negative*deltaF,my_DFT2(k_values));






