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

ius = imgaussfilt(iaj,16,'FilterSize',9);
figure(3),imshow(ius),title('Unsharped')

imask = iaj+ius;

imask = imask*0.6;

figure(4),imshow(imask),title('Enhanced')

