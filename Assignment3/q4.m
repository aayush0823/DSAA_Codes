File=load('Q4.mat');
fs=getfield(File,'Fs');
y=getfield(File,'X');
noise = audioplayer(y,fs);
playblocking(noise);
figure,
subplot(1,2,1);
plot(abs((fft(y))));
y=lowpass(y,2000,fs);
subplot(1,2,2);
plot(abs((fft(y))));
no_noise = audioplayer(y,fs);
playblocking(no_noise)