clc, clear all, close all
[file, path] = uigetfile({'*.*'},'Select file');
filename = strcat(path,file);
idcm1 = dicomread(filename);
info = dicominfo(filename);
% figure(1), imshow(idcm1);

idcm1 =im2double(idcm1);
img_max = max(max(idcm1)); img_min = min(min(idcm1));
iaj = imadjust(idcm1, [img_min img_max], [1 0]);
figure(2), imshow(iaj),title('Orginal')

avg = fspecial('average',70);
ism = imfilter(iaj, avg, 'replicate');
figure(3),imshow(ism),title('Smoothed')

ism_inv = imadjust(ism, [0 1], [1 0]);
% when multiply by constant value the image will darker
i_DRC = iaj + ism*0.01;

figure(4),imshow(i_DRC),title('DRC Postprocessing')