Image = imread("F1.jpg");
% Image = imread("Faces.jpg");
% Image = imread("download.jpeg");
% Image = imread("shapes.jpg");
% Image = imread("black-white.jpeg");

nearest_output = nearestneighbour(Image,10);
figure
imshow(nearest_output, []);
title("NEAREST NEIGHBOUR");

bilinear_output = bilinearInterpolation(Image,10);
figure
imshow(bilinear_output, []);
title("BILINEAR OUTPUT");

function [out] = nearestneighbour(Image,scale)

oldSize = size(Image);
newSize = max(floor(scale*oldSize(1:2)),1);

rowIndex = min(round(((1:newSize(1))-0.5)./scale+0.5),oldSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale+0.5),oldSize(2));

out = Image(rowIndex,colIndex,:);
end
   
function [out] = bilinearInterpolation(Image,scale)

    [cf, rf] = meshgrid(1 : size(Image,2)*scale, 1 : size(Image,1)*scale);
    
    rf = rf / scale;
    cf = cf / scale;

    r = floor(rf);
    c = floor(cf);
    
    r(r < 1) = 1;
    c(c < 1) = 1;
    r(r > size(Image,1) - 1) = size(Image,1) - 1;
    c(c > size(Image,2) - 1) = size(Image,2) - 1;

    delta_R = rf - r;
    delta_C = cf - c;

    ind1 = sub2ind([size(Image,1), size(Image,2)], r, c);
    ind2 = sub2ind([size(Image,1), size(Image,2)], r+1,c);
    ind3 = sub2ind([size(Image,1), size(Image,2)], r, c+1);
    ind4 = sub2ind([size(Image,1), size(Image,2)], r+1, c+1);       

    out = zeros(size(Image,1)*scale, size(Image,2)*scale, size(Image, 3));
    out = cast(out, class(Image));

    for i = 1 : size(Image, 3)
        j = double(Image(:,:,i));
        tmp = j(ind1).*(1 - delta_R).*(1 - delta_C) + ...
                       j(ind2).*(delta_R).*(1 - delta_C) + ...
                       j(ind3).*(1 - delta_R).*(delta_C) + ...
                       j(ind4).*(delta_R).*(delta_C);
        out(:,:,i) = cast(tmp, class(Image));
    end
end