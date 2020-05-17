% data=xlsread('frontalpoints_randomized.csv')
%%
clear;clc;close all;

%%
T=readtable('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_write_to_csv.csv');
%%
r1=table2array(T(strcmp(T.Var1,T.Var1{2}),2:end));%data(1,:);
xind=1:2:112;
yind=2:2:112;
%m=reshape(r1,[],2);
m=[(r1(xind))',(r1(yind))'];
    
%%
% k=imread(strcat('C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\ceasar_mat_test_random\' , T.Var1{2}));%train_f_csr4006b.mat.jpg');
% 
% figure
% imshow(k)
% hold on;
% plot(m(:,1),m(:,2),'rx')
% for j=1:56
%     plot(m(j,1),m(j,2),'o')
%     hold on
% end
%T=readtable('frontalpoints_randomized.csv');
%l=table2array(T(strcmp(T.Var1,'train_f_csr4006b.mat.jpg'),2:end));

%%
img_crop = imread('test_image_discrepancy.jpg');
data = xlsread('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_discrepancy.csv');
r1=data(1,:);
xind=1:2:112;
yind=2:2:112;
%m=reshape(r1,[],2);
m=[(r1(xind))',(r1(yind))'];
r2=data(2,:);
xind2=1:2:112;
yind2=2:2:112;
%m=reshape(r1,[],2);
m2=[(r2(xind2))',(r2(yind2))'];
figure
imshow(rgb2gray(img_crop))
hold on;
plot(m(:,1),m(:,2),'rx')
hold on;
plot(m2(:,1),m2(:,2),'go')
legend('predicted','groundTruth');
%%
BW = imcomplement(imbinarize(rgb2gray(img_crop)));
BW1 = edge(BW,'Canny');
[x,y]=find(BW1==1)
figure
imshow(BW1)
hold on
plot(y,x,'go')
boundary = [y,x];
%%
D=pdist2(m,boundary);
[v,ii] = min(D,[],2);
pob = zeros(56,2);
p2mig = find(v<8);
pnot2mig = find(v>=8);
pob(p2mig,:) = boundary(ii(p2mig),:);
pob(pnot2mig,:) = m(pnot2mig,:);
figure
imshow(rgb2gray(img_crop))
hold on;
plot(pob(:,1),pob(:,2),'rx');
hold on;
plot(m2(:,1),m2(:,2),'go');
legend('pointsMigratedToBoundary','groundTruth');
title('After migration');
%%
sume= (pob-m2).^2;
sqrdSum = (sume(:,1)+sume(:,2));
rmse = sqrt(sum(sqrdSum)/56)