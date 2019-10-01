A = zeros(520,256*256*3);

files=dir(fullfile('./dataset/','*.jpg'));
for i = 1:length(files)
    Image = double(imread(strcat('./dataset/',files(i).name)));
    A(i,:) = Image(:);
end

L = A * A';

[vectors, values] = eig(L);
eigvector = (vectors);
eigvalue = diag(values);

[eigvalue, index] = sort(eigvalue,'descend');
eigvector = eigvector(:, index);

%Reduce to 35 components and regenerate
components = 35;
axis = eigvector(:,1:components);

normalize = @(m) m./abs(m).*sqrt((m.^2) ./ sum(m.^2));
basis = normalize(A' * axis);
PCAspace = A*basis;

for i = 1:length(files)
    x = PCAspace(i,:);
    img = basis*x';
    
    R = col2im(img(1:256*256),[256 256], [256 256], 'distinct');
    G = col2im(img(256*256+1:2*256*256),[256 256], [256 256], 'distinct');
    B = col2im(img(2*256*256+1:3*256*256),[256 256], [256 256], 'distinct');

    compressed_img = cat(3,R,G,B);
    compressed_img = compressed_img/260;
    file_name=strcat('./compressed_dataset/',files(i).name);
    imwrite(compressed_img,file_name)
end

%1D
axis = eigvector(:,1);
normalize = @(m) m./abs(m).*sqrt((m.^2) ./ sum(m.^2));
basis = normalize(A' * axis);
PCAspace = A*basis;

figure
scatter(PCAspace(:,1),PCAspace(:,1));
title('1-D Scatter Plot');

%2D
axis = eigvector(:,1:2);
normalize = @(m) m./abs(m).*sqrt((m.^2) ./ sum(m.^2));
basis = normalize(A' * axis);
PCAspace = A*basis;

figure
scatter(PCAspace(:,1),PCAspace(:,2));
title('2-D Scatter Plot');

%3-D
axis = eigvector(:,1:3);
normalize = @(m) m./abs(m).*sqrt((m.^2) ./ sum(m.^2));
basis = normalize(A' * axis);
PCAspace = A*basis;

figure
scatter3(PCAspace(:,1),PCAspace(:,2),PCAspace(:,3));
title('3-D Scatter Plot');


%Compare for various number of components
v = [1 10 35 100 260 520];
figure
for j = 1:6
    
        axis = eigvector(:,1:v(j));
        normalize = @(m) m./abs(m).*sqrt((m.^2) ./ sum(m.^2));
        basis = normalize(A' * axis);
        PCAspace = A*basis;

        x = PCAspace(8,:);
        img = basis*x';
        R = col2im(img(1:256*256),[256 256], [256 256], 'distinct');
        G = col2im(img(256*256+1:2*256*256),[256 256], [256 256], 'distinct');
        B = col2im(img(2*256*256+1:3*256*256),[256 256], [256 256], 'distinct');
        compressed_img = cat(3,R,G,B)/260;
        subplot(2,3,j)
        imagesc(compressed_img);
        title(v(j));
end