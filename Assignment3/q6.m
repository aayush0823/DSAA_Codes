img = imread('cameraman.tif');
imgd = im2double(img);
tic;
img1 = filterine(imgd,8);
toc;
tic;
img2 = filtere(imgd,8);
toc;
figure
imshow(img1);
figure
imshow(img2);

timeeff = [];
timeinef = [];
val = [];
for x=0:5
    tic;
    img2 = filterine(imgd,2^x);
    toc;
    fin = toc;
    val = [val;2^x];
    timeinef = [timeinef;fin];
end
for x=0:5
    tic;
    img2 = filtere(imgd,2^x);
    toc;
    fin = toc;
    timeeff = [timeeff;fin];
end
figure
plot(val,timeinef);
hold on;
plot(val,timeeff,'--');
hold off;

function output = filterine(imgd,k)
imgd = padarray(imgd,k-1,'replicate','pre');
imgd = padarray(imgd,[0 k-1],'replicate','pre');
imgd = im2col(imgd,[k k]);
imgd = sum(imgd,1);
imgd = imgd./(k*k);
output = col2im(imgd,[k k],[255+k 255+k]);
end

function output = filtere(imgd,k)
imgd = padarray(imgd,k-1,'replicate','pre');
imgd = padarray(imgd,[0 k-1],'replicate','pre');
imgd = im2col(imgd,[1 k]);
imgd = sum(imgd,1);
imgd = imgd./(k*k);
output = zeros(256);
j=1:1:256;
output(1,j) = sum(imgd((j-1)*(256+k-1)+1:(j-1)*(256+k-1)+k),2);
for i=2:1:256
    output(i,j) = output(i-1,j) + imgd((j-1)*(256+k-1)+k-1+i) - imgd((j-1)*(256+k-1)+i-1);
end
end