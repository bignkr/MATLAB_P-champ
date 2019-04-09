clc, clear all, close all
[file, path] = uigetfile({'*.*'},'Select file');
filename = strcat(path,file);
I = dicomread(filename);
info = dicominfo(filename);
% figure(1), imshow(idcm1);

I =im2double(I);
img_max = max(max(I)); img_min = min(min(I));

i = imadjust(I, [img_min img_max], [1 0]);
figure(2), imshow(I),title('Orginal')

h =fspecial('average',3);
ib =imfilter(i,h,'replicate');
i = i - ib ;
isum = 0;
isum = i + isum ;
n = 5;
for n = 5:2:45
    h = fspecial('average',n);
    ib =imfilter(i,h,'replicate');
    i = i - ib ;
    isum = i + isum ;
end
figure(3), imshow(isum),title('Edge Image')
i_MFT = isum + iaj;
figure(4), imshow(i_MFT),title('MFT')

