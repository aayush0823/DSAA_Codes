N = 5;
sigma = 2;

% gaussian

I = imread("cameraman.tif");
gauss = gauss_filter(N,sigma);
out = imfilter(I,gauss);

h = fspecial("gaussian",N,sigma);
h = imfilter(I,h);
figure
imshowpair(out,h,"montage");
title("Gaussian Implemented vs fspecial at N = 32 and sigma = 2");

%median-filter
med = median_filter(I,N);
figure
subplot(1,2,1)
imshow(I);
title("ORIGINAL");
subplot(1,2,2)
imshow(med);
title("MEDIAN FILTER WITH N=3");

%best filter for inp1.png is median filter
med = median_filter(imread("inp1.png"),N);
figure
subplot(1,2,2)
imshow(med);
title("Filtered");
subplot(1,2,1)
imshow(imread('inp1.png'));
title("ORIGINAL");
%best filter for inp2.png 
I = imread('inp2.png');
V = fftshift(fft2(I));
rofil=[zeros(125,238);ones(50,238);zeros(143,238)];
filter = imfilter(rofil,gauss);
W = V.*filter;
A = ifft2((W));

figure
subplot(2,2,1)
imagesc(log(abs((V))));shading flat;colormap winter;
title('Fourier transform');
subplot(2,2,2)
imagesc(log(abs(W)));shading flat;colormap winter; 
title('Band Pass Fourier transform');
subplot(2,2,3)
imshow(I)
title('Original Image')
subplot(2,2,4)
imshow(mat2gray(abs(A)));
title('Filtered Image')


function out = median_filter(I,N)
    s = size(I);
    I = im2col(I,[N N]);
    I = median(I);
    I = col2im(I,[N N],s);
    size(I);
    out = I;
end

function out = gauss_filter(N,sigma)

range = -N : N;
[X,Y] = meshgrid(range, range);
out = exp(-(X.^2 + Y.^2) / (2*sigma*sigma));
out = out ./ sum(out(:));

end