Image = imread("Faces.jpg");
[rows,columns,bands] = size(Image);
subplot(2,2,1);
imshow(Image, []);
axis on;
title("Original Color Image");
set(gcf,"units","normalized","outerposition",[0,0,1,1]);

smallImage = imread("F1.jpg");
[rows,columns,bands] = size(smallImage);

subplot(2,2,2);
imshow(smallImage, []);
width = columns;
height = rows;
axis on;
title("Single Face");

channel = 1;
corOutput = normxcorr2(smallImage(:,:,channel),Image(:,:,channel));
subplot(2,2,3);
imshow(corOutput, []);
axis on;
title("Normalised Result");

[maxValue,maxIndex] = max(abs(corOutput(:)));
[y,x] = ind2sub(size(corOutput),maxIndex(1));

offset = [(x-size(smallImage,2)) , (y-size(smallImage,1)) ];

disp(maxValue);

subplot(2,2,4);
imshow(Image);
axis on;
hold on;
box = [offset(1) offset(2) width, height];
rectangle('position',box,'edgecolor','r','linewidth',2);
title("Face In Original Image");