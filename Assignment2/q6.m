I = imread('cameraman.tif');
I_fft = fft2(fft2(I));
%showing the image
subplot(1,2,1);
imshow(mat2gray(log(abs(I_fft)+1)));
title('DOUBLE FFT')
I_flip = flip(fft2(flip(fft2(I),1)),2);
subplot(1,2,2);
imshow(mat2gray(log(abs(I_flip)+1)));
title('FLIP');