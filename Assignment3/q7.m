dataset=csvread('Altitude.csv');
train_set = [ones(900,1) dataset(1:900,1) dataset(1:900,2)];
test_set = [ones(100,1) dataset(901:1000,1) dataset(901:1000,2)];
y_train = dataset(1:900,3);
y_test = dataset(901:1000,3);

%Normalised
train_set(:,2) = (train_set(:,2) - min(train_set(:,2)))/(max(train_set(:,2)) - min(train_set(:,2)));
train_set(:,3) = (train_set(:,3) - min(train_set(:,3)))/(max(train_set(:,3)) - min(train_set(:,3)));

%Batch
theta_batch = [0 0 0]';
iter = 0;

while iter < 1000
    error =(train_set*theta_batch - y_train)';
    theta_batch(1) = theta_batch(1) - 0.01/1000*(error*train_set(:,1));
    theta_batch(2) = theta_batch(2) - 0.01/1000*(error*train_set(:,2));
    theta_batch(3) = theta_batch(3) - 0.01/1000*(error*train_set(:,3));
    iter = iter+1;
end

test_set(:,2) = (test_set(:,2) - min(train_set(:,2)))/(max(train_set(:,2)) - min(train_set(:,2)));
test_set(:,3) = (test_set(:,3) - min(train_set(:,3)))/(max(train_set(:,3)) - min(train_set(:,3)));

output = test_set*theta_batch;

%L2 Norm
l2=(output-y_test).^2;
disp('L2 Norm Batch');
disp(sqrt(sum(l2)));


%Stochastic
dataset=csvread('Altitude.csv');
dataset=dataset(randperm(1000),:);
train_set = [ones(900,1) dataset(1:900,1) dataset(1:900,2)];
test_set = [ones(100,1) dataset(901:1000,1) dataset(901:1000,2)];
y_train = dataset(1:900,3);
y_test = dataset(901:1000,3);

%Normalised
train_set(:,2) = (train_set(:,2) - min(train_set(:,2)))/(max(train_set(:,2)) - min(train_set(:,2)));
train_set(:,3) = (train_set(:,3) - min(train_set(:,3)))/(max(train_set(:,3)) - min(train_set(:,3)));
theta_stoc=[0 0 0]';
for i=1:1000
     for j=1:900
     temp=(train_set(j,:)*theta_stoc-y_train(j))';
     theta_stoc=theta_stoc-0.01/900*(temp*train_set(j,:))';
     end
end
test_set(:,2) = (test_set(:,2) - min(train_set(:,2)))/(max(train_set(:,2)) - min(train_set(:,2)));
test_set(:,3) = (test_set(:,3) - min(train_set(:,3)))/(max(train_set(:,3)) - min(train_set(:,3)));

output = test_set*theta_stoc;

%L2 Norm
l2=(output-y_test).^2;
disp('L2 Norm Stochastic');
disp(sqrt(sum(l2)));