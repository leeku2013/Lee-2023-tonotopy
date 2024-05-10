Fs = 20000;            % Sampling frequency 60024
T = 1/Fs;             % Sampling period
L = 6000;             % Length of signal
t = (0:L-1)*T;        % Time vector
s=sin(2*pi*600*t);
plot(s)
%s=sin(2*pi*600*t).*(sin(2*pi*800*t));
s=sin(2*pi*600*t)+(sin(2*pi*800*t));
%s=a;
%s=sin(2*pi*3600*t).*(sawtooth(2*pi*1*(t)-1.59,0.5));
plot(s)
Y = fft(s);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
figure; plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')