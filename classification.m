%%
clear;clc;
%%
filePath = "C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\ceasar_700b_predict_model_NN\";
% Files=dir(fullfile(filePath,'*.mat'));
filePattern = fullfile(filePath, '*.mat');
matFiles = dir(filePattern);
error_all=zeros(50,697);
I=[];
tic
 for i=1:50
    baseFileName = matFiles(i).name;
    fullFileName = fullfile(filePath, baseFileName);
    model = load(fullFileName);
%     ori_dense = model.model.ori_dense_model;
    recon = model.model.recon_model;
%     error = calcError3d(ori_dense,recon);
    
% end
err=[];
    parfor j=1:697
        baseFileName = matFiles(j).name;
        fullFileName = fullfile(filePath, baseFileName);
        model = load(fullFileName);
        ori_dense = model.model.ori_dense_model;
        [A,B]=NNSearch3DFEX(ori_dense,recon);
        error = mean(B);
%         err=[err;error];
        
%         recon = model.model.recon_model;
%         error = calcError3d(ori_dense,recon);
% orig = ori_dense;
% % recon = 
%         x = (orig(:,1)-recon(:,1)).^2;
% y = (orig(:,2)-recon(:,2)).^2;
% z = (orig(:,3)-recon(:,3)).^2;
% d = x + y + z
% dist = sqrt(d)
% error = mean(dist);
        error_all(i,j)=error;
    end
%     [minv,ind]=min(err);
%     I=[I;ind];
end
toc
%%
[M,I]=min(error_all,[],2);
count = 0;
for k=1:length(I)
    v = I(k);
    if v==k
        count = count + 1;
    end
end
success = (count/50)*100;
        