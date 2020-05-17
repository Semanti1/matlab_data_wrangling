data=xlsread('frontalpoints_randomized.csv')

%%
r1=data(1,:);
xind=1:2:112;
yind=2:2:112;
%m=reshape(r1,[],2);
m=[(r1(xind))',(r1(yind))'];
    
%%
k=imread('C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\ceasar_mat\train_f_csr4006b.mat.jpg');

figure
imshow(k)
hold on;
%plot(m(:,2),m(:,1),'rx')
for j=1:56
    plot(m(j,1),m(j,2),'o')
    hold on
end