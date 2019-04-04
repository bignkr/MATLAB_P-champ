clc, clear all, close all
[file, path] = uigetfile({'*.*'},'Select file');
filename = strcat(path,file);
img = dicomread(filename);
info = dicominfo(filename);
img2=im2double(img);
img_max=max(max(img2));
img_min=min(min(img2));
chest=imadjust(img2,[img_min img_max], []);
chest_inv=imadjust(chest, [0 1], [1 0]);
h=medfilt2(chest_inv,[3 3]);
A=chest_inv-h;
B=(A*0.8)+chest_inv;
figure(1), subplot(2,2,1), imshow(chest_inv), title('Original Image');
subplot(2,2,2), imshow(h), title('Unsharp Image');
subplot(2,2,3), imshow(A), title('Edge extraction');
subplot(2,2,4), imshow(B), title('Enhanced Image');
axis image,axis off