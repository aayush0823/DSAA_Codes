image = imread('cameraman.tif');
image = imresize(image,[64,64]);
pad128 = padarray(image,[64 64],0,'post');
pad256 = padarray(pad128,[128 128],0,'post');
pad512 = padarray(pad256,[256 256],0,'post');

figure
subplot(221);
imagesc(log(fftshift(abs(fft2(image)))+1));colormap gray;
subplot(222);
imagesc(log(fftshift(abs(fft2(pad128)))+1));colormap gray;
subplot(223);
imagesc(log(fftshift(abs(fft2(pad256)))+1));colormap gray;
subplot(224);
imagesc(log(fftshift(abs(fft2(pad512)))+1));colormap gray;