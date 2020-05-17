
%%
clear;clc;close all;

%%
rmse_side=[];
rmse_frontal=[];
data_orig = readtable('C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\sideviewpoints_testing_last700.csv');
data_pred = readtable('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_write_to_csv_profile_last700.csv');
data_frontal_pred = readtable('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_write_to_csv_frontal_last700.csv');
data_orig_frontal = readtable('C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\frontalpoints_testing_last700.csv');
for i=1:701
    fname = data_orig.Var1{i};
    path = strcat('C:\\Users\\Semanti Basu\\Documents\\OneDrive_2020-02-19\\3D Ceaser dataset\\Image and point generation\\Image and point generation\\ceasar_mat_test_last700\\' , fname);
    img_crop= imread(path);
    r1=table2array(data_pred(strcmp(data_pred.Var1,fname),2:end));
    xind=1:2:52;
    yind=2:2:52;
    %m=reshape(r1,[],2);
    m_side=[(r1(xind))',(r1(yind))'];
    % r2=data(2,:);
    r2 = table2array(data_orig(strcmp(data_orig.Var1,fname),2:end));
    xind2=1:2:52;
    yind2=2:2:52;
    %m=reshape(r1,[],2);
    % m2=[(r2(xind2))' + 35,(r2(yind2))'];
    m2_side=[(r2(xind2))',(r2(yind2))'];
    figure
    imshow(rgb2gray(img_crop))
    hold on;
    plot(m_side(:,1),m_side(:,2),'rx')
    hold on;
    plot(m2_side(:,1),m2_side(:,2),'go')
    legend('predicted','groundTruth');
    BW = imcomplement(imbinarize(rgb2gray(img_crop)));
    BW1 = edge(BW,'Canny');
    [x,y]=find(BW1==1)
    figure
    imshow(BW1)
    hold on
    plot(y,x,'go')
    boundary = [y,x];
    
    D=pdist2(m_side,boundary);
    [v,ii] = min(D,[],2);
    pob_side = zeros(26,2);
    p2mig = find(v<8);
    pnot2mig = find(v>=8);
    pob_side(p2mig,:) = boundary(ii(p2mig),:);
    pob_side(pnot2mig,:) = m_side(pnot2mig,:);
    figure
    imshow(rgb2gray(img_crop))
    hold on;
    plot(pob_side(:,1),pob_side(:,2),'rx');
    hold on;
    plot(m2_side(:,1),m2_side(:,2),'go');
    legend('pointsMigratedToBoundary','groundTruth');
    title('After migration');
    PM_CTRL_PT_predict = [pob_side(:,2),pob_side(:,1)];
    if ~exist('predicted_side_last701') 
        mkdir predicted_side_last701
    end
    fileTosave = "predicted_side_last701/"+fname(1:end-4);
    save(fileTosave, 'PM_CTRL_PT_predict');
    imwrite(img_crop, fileTosave+".jpg");
    sume= (pob_side-m2_side).^2;
    sqrdSum = (sume(:,1)+sume(:,2));
    rmseSide = sqrt(sum(sqrdSum)/26);
    disterr=sum(sqrt(sqrdSum))/26;
    rmse_side = [rmse_side;disterr];
    close all;
    fname(6)='f';
    path = strcat('C:\\Users\\Semanti Basu\\Documents\\OneDrive_2020-02-19\\3D Ceaser dataset\\Image and point generation\\Image and point generation\\ceasar_mat_test_last700\\' , fname);
    img_crop= imread(path);
    r1=table2array(data_frontal_pred(strcmp(data_frontal_pred.Var1,fname),2:end));
%     img_crop = imread('C:\\Users\\Semanti Basu\\Documents\\OneDrive_2020-02-19\\3D Ceaser dataset\\Image and point generation\\Image and point generation\\ceasar_mat_test_random\\test_f_csr4136b.mat.jpg');
%     data = xlsread('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_discrepancy.csv');
%     r1=data(1,:);
    xind=1:2:112;
    yind=2:2:112;
    %m=reshape(r1,[],2);
    m=[(r1(xind))',(r1(yind))'];
    % r2=data(2,:);
    r2 = table2array(data_orig_frontal(strcmp(data_orig_frontal.Var1,fname),2:end));
    xind2=1:2:112;
    yind2=2:2:112;
    %m=reshape(r1,[],2);
    % m2=[(r2(xind2))' + 35,(r2(yind2))'];
    m2=[(r2(xind2))',(r2(yind2))'];
    figure
    imshow(rgb2gray(img_crop))
    hold on;
    plot(m(:,1),m(:,2),'rx')
    hold on;
    plot(m2(:,1),m2(:,2),'go')
    legend('predicted','groundTruth');

    BW = imcomplement(imbinarize(rgb2gray(img_crop)));
    BW1 = edge(BW,'Canny');
    [x,y]=find(BW1==1)
    figure
    imshow(BW1)
    hold on
    plot(y,x,'go')
    boundary = [y,x];

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
    close all;
    PM_CTRL_PT_predict = [pob(:,2),pob(:,1)];
    if ~exist('predicted_frontal_last701') 
        mkdir predicted_frontal_last701
    end
    fileTosave = "predicted_frontal_last701/"+fname(1:end-4);
    save(fileTosave, 'PM_CTRL_PT_predict');
    imwrite(img_crop, fileTosave+".jpg");
    sume= (pob-m2).^2;
    sqrdSum = (sume(:,1)+sume(:,2));
    rmseFrontal = sqrt(sum(sqrdSum)/56);
    distErrFrontal = sum(sqrt(sqrdSum))/56;
    rmse_frontal=[rmse_frontal;distErrFrontal];
%     break;
end

%%
% img_crop = imread('C:\\Users\\Semanti Basu\\Documents\\OneDrive_2020-02-19\\3D Ceaser dataset\\Image and point generation\\Image and point generation\\ceasar_mat_test_random\\test_f_csr4136b.mat.jpg');
% data = xlsread('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_discrepancy.csv');
% r1=data(1,:);
% xind=1:2:112;
% yind=2:2:112;
% %m=reshape(r1,[],2);
% m=[(r1(xind))' + 35,(r1(yind))'];
% % r2=data(2,:);
% r2 = data_orig(18,:);
% xind2=1:2:112;
% yind2=2:2:112;
% %m=reshape(r1,[],2);
% % m2=[(r2(xind2))' + 35,(r2(yind2))'];
% m2=[(r2(xind2))',(r2(yind2))'];
% figure
% imshow(rgb2gray(img_crop))
% hold on;
% plot(m(:,1),m(:,2),'rx')
% hold on;
% plot(m2(:,1),m2(:,2),'go')
% legend('predicted','groundTruth');
% %%
% BW = imcomplement(imbinarize(rgb2gray(img_crop)));
% BW1 = edge(BW,'Canny');
% [x,y]=find(BW1==1)
% figure
% imshow(BW1)
% hold on
% plot(y,x,'go')
% boundary = [y,x];
% %%
% D=pdist2(m,boundary);
% [v,ii] = min(D,[],2);
% pob = zeros(56,2);
% p2mig = find(v<8);
% pnot2mig = find(v>=8);
% pob(p2mig,:) = boundary(ii(p2mig),:);
% pob(pnot2mig,:) = m(pnot2mig,:);
% figure
% imshow(rgb2gray(img_crop))
% hold on;
% plot(pob(:,1),pob(:,2),'rx');
% hold on;
% plot(m2(:,1),m2(:,2),'go');
% legend('pointsMigratedToBoundary','groundTruth');
% title('After migration');
% %%
% sume= (pob-m2).^2;
% sqrdSum = (sume(:,1)+sume(:,2));
% rmse_frontal = sqrt(sum(sqrdSum)/56);
% 
% %%
% data_orig_side = xlsread('C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\sideviewpoints_random_test.csv');
% img_crop = imread('C:\\Users\\Semanti Basu\\Documents\\OneDrive_2020-02-19\\3D Ceaser dataset\\Image and point generation\\Image and point generation\\ceasar_mat_test_random\\test_s_csr4136b.mat.jpg');
% data = xlsread('C:\Users\Semanti Basu\PycharmProjects\ControlPointsDetection\test_discrepancy_side.csv');
% r1=data(1,:);
% xind=1:2:52;
% yind=2:2:52;
% %m=reshape(r1,[],2);
% m_side=[(r1(xind))',(r1(yind))'];
% % r2=data(2,:);
% r2 = data_orig_side(18,:);
% xind2=1:2:52;
% yind2=2:2:52;
% %m=reshape(r1,[],2);
% % m2=[(r2(xind2))' + 35,(r2(yind2))'];
% m2_side=[(r2(xind2))',(r2(yind2))'];
% figure
% imshow(rgb2gray(img_crop))
% hold on;
% plot(m_side(:,1),m_side(:,2),'rx')
% hold on;
% plot(m2_side(:,1),m2_side(:,2),'go')
% legend('predicted','groundTruth');
% %%
% BW = imcomplement(imbinarize(rgb2gray(img_crop)));
% BW1 = edge(BW,'Canny');
% [x,y]=find(BW1==1)
% figure
% imshow(BW1)
% hold on
% plot(y,x,'go')
% boundary = [y,x];
% %%
% D=pdist2(m_side,boundary);
% [v,ii] = min(D,[],2);
% pob_side = zeros(26,2);
% p2mig = find(v<8);
% pnot2mig = find(v>=8);
% pob_side(p2mig,:) = boundary(ii(p2mig),:);
% pob_side(pnot2mig,:) = m_side(pnot2mig,:);
% figure
% imshow(rgb2gray(img_crop))
% hold on;
% plot(pob_side(:,1),pob_side(:,2),'rx');
% hold on;
% plot(m2_side(:,1),m2_side(:,2),'go');
% legend('pointsMigratedToBoundary','groundTruth');
% title('After migration');
% %%
% sume= (pob_side-m2_side).^2;
% sqrdSum = (sume(:,1)+sume(:,2));
% rmse_side = sqrt(sum(sqrdSum)/56);
