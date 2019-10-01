img = imread('LAKE.TIF');
quant_matrix = [16 11 10 16 24 40 51 61;
                12 12 14 19 26 58 60 55;
                14 13 16 24 40 57 69 56;
                14 17 22 29 51 87 80 62;
                18 22 37 56 68 109 103 77;
                24 35 55 64 81 104 113 92;
                49 64 78 87 103 121 120 101;
                72 92 95 98 112 100 103 99];
% part 1a
my_dct = create_mat_dct();
inbuilt_dct = dctmtx(8);
if(max(my_dct - inbuilt_dct) < 0.0001)
    disp("create_mat_dct Correctly Implemented");
end

img8 = imresize(img,[8 8]);
%part 1b
my_dct2 = myDCT(img8,my_dct);
inbuilt_dct2 = dct2(img8);
if(max(my_dct2 - inbuilt_dct2) < 0.0001)
    disp("myDCT Correctly Implemented");
end

% part 1c
my_idct = myIDCT(my_dct2,my_dct);
inbuilt_idct = idct2(my_dct2);
if(max(my_idct - inbuilt_idct) < 0.0001)
    disp("myIDCT Correctly Implemented");
end

%part 1d
quantise = myDCT_quantization(my_dct2,quant_matrix,3);

%part 1e
dequantise = myDCT_dequantization(quantise,quant_matrix,3);

%part 1f
error = RMSE(img,img+2);

%part 1g
my_entropy = My_entropy(img);
inbuilt_entropy = entropy(img);

if((my_entropy - inbuilt_entropy) < 0.0001)
    disp("My_entropy Correctly Implemented");
end

%part 2
imgpart = img(420:427,45:52) - 127;
dct = myDCT(imgpart,my_dct);
dctq = myDCT_quantization(dct,quant_matrix,3);
dctq = round(dctq);
regen = myDCT_dequantization(dctq,quant_matrix,3);
regen = myIDCT(regen,create_mat_dct()) + 127;
figure
subplot (341)
imagesc(imgpart); colormap gray;
title('Original');
subplot (342)
imagesc(dct); colormap gray;
title('DCT');
subplot (343)
imagesc(dctq); colormap gray;
title('DCT & QUANTIZE');
subplot (344)
imagesc(regen); colormap gray;
title('REGENERATED');

imgpart = img(427:434,298:305)-127;
dct = myDCT(imgpart,my_dct);
dctq = myDCT_quantization(dct,quant_matrix,3);
dctq = round(dctq);
regen = myDCT_dequantization(dctq,quant_matrix,3);
regen = myIDCT(regen,create_mat_dct())+127;
subplot (345)
imagesc(imgpart); colormap gray;
title('Original');
subplot (346)
imagesc(dct); colormap gray;
title('DCT');
subplot (347)
imagesc(dctq); colormap gray;
title('DCT & QUANTIZE');
subplot (348)
imagesc(regen); colormap gray;
title('REGENERATED');

imgpart = img(30:37,230:237)-127;
dct = myDCT(imgpart,my_dct);
dctq = myDCT_quantization(dct,quant_matrix,2);
dctq = round(dctq);
regen = myDCT_dequantization(dctq,quant_matrix,2);
regen = myIDCT(regen,create_mat_dct())+127;
subplot (349)
imagesc(imgpart); colormap gray;
title('Original');
subplot (3,4,10)
imagesc(dct); colormap gray;
title('DCT');
subplot (3,4,11)
imagesc(dctq); colormap gray;
title('DCT & QUANTIZE');
subplot (3,4,12)
imagesc(regen); colormap gray;
title('REGENERATED');

%part 3 
fun = @(img) myDCT(img.data,my_dct);
dct = blockproc(img,[8 8],fun);
fun = @(block_struct) myDCT_quantization(block_struct.data,quant_matrix,2);
quant = blockproc(dct,[8 8],fun);
quant = round(quant);
fun = @(block_struct) myDCT_dequantization(block_struct.data,quant_matrix,2);
dequant = blockproc(quant,[8 8],fun);
fun = @(block_struct) myIDCT(block_struct.data,my_dct);
imgreg = blockproc(dequant,[8 8],fun);

figure
subplot(121)
imagesc(img);
title('ORIGINAL'); colormap gray;
subplot(122)
imagesc(imgreg);
title('REGENERATED'); colormap gray;

%part 4
rms = [];
ent = [];
val = [];

fun = @(img) myDCT(img.data,my_dct);
dct = blockproc(img,[8 8],fun);
fun = @(block_struct) myDCT_quantization(block_struct.data,quant_matrix,10);
quant = blockproc(dct,[8 8],fun);
quant = round(quant);
fun = @(block_struct) myDCT_dequantization(block_struct.data,quant_matrix,10);
dequant = blockproc(quant,[8 8],fun);
fun = @(block_struct) myIDCT(block_struct.data,my_dct);
imgreg = blockproc(dequant,[8 8],fun);
% disp(RMSE(im2double(img),imgreg));
% disp(My_entropy(imgreg));

figure
subplot(121)
imagesc(img);
title('ORIGINAL'); colormap gray;
subplot(122)
imagesc(imgreg);
title('REGENERATED'); colormap gray;

for j = 1:6

fun = @(img) myDCT(img.data,my_dct);
dct = blockproc(img,[8 8],fun);
fun = @(block_struct) myDCT_quantization(block_struct.data,quant_matrix,2^j);
quant = blockproc(dct,[8 8],fun);
quant = round(quant);
fun = @(block_struct) myDCT_dequantization(block_struct.data,quant_matrix,2^j);
dequant = blockproc(quant,[8 8],fun);
fun = @(block_struct) myIDCT(block_struct.data,my_dct);
imgreg = blockproc(dequant,[8 8],fun);

r=RMSE(im2double(img),imgreg);
e=My_entropy(imgreg);
rms = [rms,r];
ent = [ent;e];
val = [val,2^j];

end


figure
plot(val,rms);
title("RMS ERROR");
figure
plot(val,ent)
title("ENTROPY");

function output = create_mat_dct()
n=8;
u = (0:n-1);
v = (1:n-1)';
angle = 2*pi*v*(2*u+1)/(4*n);
inmatrix = sqrt(2/n)*cos(angle);
firstcol = sqrt(1/n)*ones(1,8);
output = [firstcol;inmatrix];
end

function output = myDCT(im,F)
im = double(im);
output = ((im*F')'*F')';
end

function output = myIDCT(im,F)
output = ((im*F)'*F)';
end

function output = myDCT_quantization(imDCT,qm,c)
qm = qm*c;
output = imDCT./qm;
end

function output = myDCT_dequantization(imqDCT,qm,c)
qm = qm*c;
output = imqDCT.*qm;
end

function output = RMSE(im1,im2)
output = sqrt(sum(sum(((im1-im2).^2)))/(size(im1,1)*size(im2,2)));
end

function output = My_entropy(im)
p = imhist(im);
p = p/(size(im,1)*size(im,2));
p = nonzeros(p);
output = -sum(p.*log(p));
end