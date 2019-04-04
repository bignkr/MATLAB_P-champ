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
i = iaj;

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
figure(3), imshow(isum,[]),title('Edge Image')
i_MFT = isum + iaj;
figure(4), imshow(i_MFT,[]),title('MFT')
%% 
% iaj = iaj;
% n = 9;
% for n = 9:11;
%     ius = imgaussfilt(iaj,16,'FilterSize',n); 
%     iaj = iaj - ius ;
%     n = n+2;
% end
% figure(3), imshow(iaj),title('Edge Image')

%% avarage
% avg = fspecial('average',3);
% iaj = imfilter(iaj, avg, 'replicate');
% avg = fspecial('average',5);
% ius = imfilter(iaj, avg, 'replicate');
% iaj1 = iaj-ius;
% avg = fspecial('average',7);
% ius = imfilter(iaj1, avg, 'replicate');
% iaj2 = iaj-ius;
% avg = fspecial('average',9);
% ius = imfilter(iaj2, avg, 'replicate');
% iaj3 = iaj2-ius;
% avg = fspecial('average',11);
% ius = imfilter(iaj3, avg, 'replicate');
% iaj4 = iaj3-ius;
% avg = fspecial('average',13);
% ius = imfilter(iaj, avg, 'replicate');
% iaj5 = iaj4-ius;
% avg = fspecial('average',15);
% ius = imfilter(iaj5, avg, 'replicate');
% iaj6 = iaj5-ius;
% avg = fspecial('average',17);
% ius = imfilter(iaj6, avg, 'replicate');
% iaj7 = iaj6-ius;

%% guassian
% ius = imgaussfilt(iaj,16,'FilterSize',9); 
% iaj1 = iaj - ius ;
% ius = imgaussfilt(iaj1,16,'FilterSize',11);
% iaj2 = iaj1 - ius ;
% ius = imgaussfilt(iaj2,16,'FilterSize',13);
% iaj3 = iaj2 - ius ;
% ius = imgaussfilt(iaj3,16,'FilterSize',15);
% iaj4 = iaj3 - ius ;
% ius = imgaussfilt(iaj4,16,'FilterSize',17);
% iaj5 = iaj4 - ius ;
% ius = imgaussfilt(iaj5,16,'FilterSize',19);
% iaj6 = iaj5 - ius ;
% ius = imgaussfilt(iaj6,16,'FilterSize',21);
% iaj7 = iaj6 - ius ;
% 
% iedge = iaj1+iaj2+iaj3+iaj4+iaj5+iaj6+iaj7;
% figure(3), imshow(iedge),title('Edge Image')
% i_MFP = iedge + iaj;
% figure(4), imshow(i_MFP),title('MFP')
