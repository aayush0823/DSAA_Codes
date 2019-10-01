Image = imread('cameraman.tif');
[n m] = size(Image);
Image = double(Image);
% Image = rand(2048/2,2048/2);
tic
C = fftshift(DFT(Image));
figure,subplot(1,2,1)
imagesc(mat2gray(log(abs(C)+1))), colormap gray;
title('Using my DFT function');
toc
tic
D = fftshift(fft2(Image));
subplot(1,2,2)
imagesc(mat2gray(log(abs(D)+1))), colormap gray;
title('Using Inbuilt function');
toc

%fft
tic
C = fftshift(FFT(FFT(Image).').');
figure,subplot(1,2,1)
imagesc(mat2gray(log(abs(C)+1))), colormap gray;
title('Using my FFT function');
toc
tic
D = fftshift(fft2(Image));
subplot(1,2,2)
imagesc(mat2gray(log(abs(D)+1))), colormap gray;
title('Using Inbuilt function');
toc

function output = DFT(Image)
[n m] = size(Image);
[n1,k1] = meshgrid(0:n-1);
[n2,k2] = meshgrid(0:m-1);
output = exp(-i.*2.*pi.*n1.*k1./n)*Image*exp(-i.*2.*pi.*n2.*k2./m);
end

function output = FFT(Image)
    [n m] = size(Image);
    odd = zeros(round(n/2),m);
    even = zeros(round(n/2),m);
    
    even = Image((2:2:n),:);
    odd = Image((1:2:n),:);
    
    if n == 1
        output = Image;
    else        
        fodd = FFT(odd);
        
        feven = FFT(even);
        ex = exp((-i*2*pi)/n);
        ex = ex.^(meshgrid(0:n/2-1,1:m))';
        output_left = feven + ex.*fodd;
        output_right = feven - ex.*fodd;
        output = [output_left;output_right];
    end        
end