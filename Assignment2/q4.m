[y,fs] = audioread("signal_4.wav");
y2 = audioplayer(y,fs);
playblocking(y2);
figure
subplot(2,1,1)
plot(y);
title('Original');
% x1 = smoothdata(y,"movmean");
% x2 = smoothdata(y,"movmedian");%no
% x3 = smoothdata(y,"gaussian");
% x4 = smoothdata(y,"lowess");
% x5 = smoothdata(y,"loess");%no
% x6 = smoothdata(y,"rlowess");%no
% x7 = smoothdata(y,"sgolay");%no at start
% x8 = smoothdata(y,"rloess");%no

fftcal = fft(y);
mean_value = mean(abs(fftcal));
fftcal( abs(fftcal) < 4*mean_value ) = 0;
y = ifft(fftcal);
y1 = audioplayer(y,fs);
subplot(2,1,2)
plot(y);
title('Filtered');
playblocking(y1);