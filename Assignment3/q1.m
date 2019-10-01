dataset=csvread('houses.csv');

input_train=[ones(42,1) dataset(1:42,1:2)];
output_train=dataset(1:42,3);
input_test=[ones(5,1) dataset(43:47,1:2)];
output_test=dataset(43:47,3);

%NO NORMALISATION
coeff=inv(input_train'*input_train)*input_train'*output_train;
output=input_test*coeff;
%Non-Normalised Coefficients
disp(coeff);

%NORMALISATION
area = input_train(:,2);
bed = input_train(:,3);
minarea = min(area);
maxarea = max(area);
minbed = min(bed);
maxbed = max(bed);
area = (area - minarea)./(maxarea-minarea);
bed = (bed - minbed)./(maxbed-minbed);
input_norm = [ones(42,1) area bed];
coeffnorm=inv(input_norm'*input_norm)*input_norm'*output_train;
area_test = input_test(:,2);
area_test = (area_test - minarea)./(maxarea-minarea);
bed_test = input_test(:,3);
bed_test = (bed_test - minbed)./(maxbed-minbed);
input_norm_test = [ones(5,1) area_test bed_test];
output_norm=input_norm_test*coeffnorm;

%Normalised Coefficients
disp(coeffnorm);

%Output with 1400 area and 4 bedrooms
value = coeff(1) + 1400*coeff(2) + 4*coeff(3);
disp('Answer for 1400 area and 4 bedrooms');
disp(value);

%L2 Norm
l2=(output_test-output).^2;
disp('L2 Norm');
disp(sqrt(sum(l2)));

%Mean
meanarea = mean(input_train(:,2));
meanbed = mean(input_train(:,3));
meanoutput = mean(output_train);
predmeanoutput = coeff(1) + coeff(2)*meanarea + coeff(3)*meanbed;
if abs(meanoutput - predmeanoutput) < 0.1
    disp('Mean lies on regression line');
else
    disp('Mean does not lie on regression line');
end