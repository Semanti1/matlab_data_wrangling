clear;clc;
filePath = "C:\Users\Semanti Basu\Documents\OneDrive_2020-02-19\3D Ceaser dataset\Image and point generation\Image and point generation\ceasar_mat_test_random\";
% Files=dir(fullfile(filePath,'*.mat'));
filePattern = fullfile(filePath, '*.mat');
matFiles = dir(filePattern);
matData={};
for k = 1:100
% for k=1:3
  baseFileName = matFiles(k).name;
  fullFileName = fullfile(filePath, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  temp = load(fullFileName);
%   temp.points
  matData(end+1,:)={baseFileName+".jpg",reshape((temp.points)',1,112)};
%   matData{baseFileName}=reshape((temp.points)',1,112)
end
T=cell2table(matData);
writetable(T,'frontalpoints_random_test.csv','WriteVariableNames',false);
%%
matData={};
for k = 101:200
% for k=1:3
  baseFileName = matFiles(k).name;
  fullFileName = fullfile(filePath, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  temp = load(fullFileName);
%   temp.points
  matData(end+1,:)={baseFileName+".jpg",reshape((temp.points)',1,52)};
%   matData{baseFileName}=reshape((temp.points)',1,112)
end
T2=cell2table(matData);
writetable(T2,'sideviewpoints_random_test.csv','WriteVariableNames',false);