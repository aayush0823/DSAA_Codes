% PART-A
Image1 = imread('cameraman.tif');
Image2 = imread('sample.jpeg');
Image2 = rgb2gray(Image2);

Image1 = imresize(Image1,[256,256]);
Image2 = imresize(Image2,[256,256]);

% By Convolution
One = conv2(Image1,Image2);

% By FFT
Other = ifft2(fft2(Image1).*fft2(Image2));

%making size equal
OneReduce = One(ceil(size(One,1)/2)-127:ceil(size(One,1)/2)+128,ceil(size(One,2)/2)-127:ceil(size(One,2)/2)+128);

diff = OneReduce-Other;
if diff == zeros(256,256) 
    disp("Convolution and FFT equal");
else
    disp("Not Equal");
end

%PART-B
diff = diff.^2;
average = sum(sum(diff./(256*256),1),2);
disp(average);

%PART-C
Image1pad = padarray(Image1,[255 255],0,'post');
Image2pad = padarray(Image2,[255 255],0,'post');
NewFFT = ifft2(fft2(Image1pad).*fft2(Image2pad));
diff2 = One-NewFFT;
if diff2 == zeros(511,511) 
    disp("Convolution and FFT equal");
else
    disp("Not Equal");
end
diff2 = diff2.^2;
average2 = sum(sum(diff2./(511*511),1),2);
disp(average2);

figure
subplot(221);
imagesc(OneReduce);
title('Centre Convolution');
subplot(222);
imagesc(abs(Other));
title('FFT Without Pad');
subplot(223);
imagesc(One);
title('Convolution');
subplot(224);
imagesc(abs(NewFFT));
title('Padded FFT');
