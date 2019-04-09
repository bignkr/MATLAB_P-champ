clc, clear all, close all
%% Display to User input
disp('MATLAB MFP post processing');
disp('Please enter the number of the following setting');
img = input('1.DICOM or 2.normal image (type: 1 or 2):');
met = input('Filter? 1.Average 2.Gaussian (type: 1 or 2):') ;
if met == 2
    g = input('Unsharp level(SD of gaussian filter):');
    f = input('Filter size?(odd number only): ');
else
    f = input('Filter size?(odd number only): ');
end
loop = input('The level of adjusting?(How many loop you want?): ');
mode = input('Display in 1. multiwindows or 2. subplot? (type: 1 or 2): ');
%% Image reading
if img == 1
    %Find DICOM file
    [file, path] = uigetfile({'*.*'},'Select DICOM file');
    filename = strcat(path,file);
	I = dicomread(filename);
	info = dicominfo(filename);
    %Making DICOM file visible
	I = im2double(I);
	img_max = max(max(I)); img_min = min(min(I));
	I = imadjust(I, [img_min img_max], [1 0]);
else
	[file, path] = uigetfile({'*.*'},'Select file');
	filename = strcat(path,file);
	I = imread(filename);
end
%% MFP adjustment
I1 = I; %keep in another variable for begin the loop
%Average
if met == 1
    h = fspecial('average',f); % filter which can be adjusted
    Ib1 = imfilter(I,h,'replicate'); %blur filtering
    Im1 = I1 - Ib1; %Masking image
    Ib2 = imfilter(Ib1,h,'replicate');
    Im2 = Ib1 - Ib2 ;
    Ims = Im1 + Im2; % The sum of initial masking image
    Ims2 = 0 ;%for making sum of masking image in loop

    % Looping average
    for x = 1:loop % the loop which can be adjusted
        Ib3 = imfilter(Ib2,h,'replicate');
        Im3 = Ib2 - Ib3; % Masking image in loop
        Ims2 = Ims2 + Im3; %The sum of masking image in loop
    end

else %Gaussian
    Ib1 = imgaussfilt(I,g,'FilterSize',f);%Unshaped Image
    Im1 = I1 - Ib1; %Masking image
    Ib2 = imgaussfilt(Ib1,g,'FilterSize',f);
    Im2 = Ib1 - Ib2 ;
    Ims = Im1 + Im2; % The sum of initial masking image
    Ims2 = 0 ;%for making sum of masking image in loop

    % Looping average
    for x = 1:loop % the loop which can be adjusted
        Ib3 = imgaussfilt(Ib2,g,'FilterSize',f);
        Im3 = Ib2 - Ib3; % Masking image in loop
        Ims2 = Ims2 + Im3; %The sum of masking image in loop
    end
end
%%
Ims = Ims + Ims2; %Initial + Loop masking
Imfp = I1 + Ims; % Making the MFP image

%% MFT Output display
if mode == 1
	figure(1),imshow(I),axis tight,title('Original')
	figure(2),imhist(I),axis tight,axis([0.9 1 0 2*10^6]),title('Original histogram')
	figure(3),imshow(Imfp),axis tight,title('MFP')
	figure(4),imhist(Imfp),axis tight,axis([0.9 1 0 2*10^6]),title('Histogram MFP')
	figure(5),imshow(Ims),title('Masking')
	figure(6),imhist(Ims),axis tight,title('Masking histogram'),axis([0.9 1 0 2*10^6]),title('Histogram MFP')
else
    figure(1)
	subplot(131),imshow(I),axis tight,title('Original')
    subplot(132),imshow(Imfp),axis tight,title('MFP')
    subplot(133),imshow(Ims),axis tight,title('Masking')
    figure(2)
	subplot(311),imhist(I),axis tight,title('Original histogram'),axis([0.9 1 0 2*10^6]),title('Histogram MFP')
	subplot(312),imhist(Imfp),axis tight,title('MFP histogram'),axis([0.9 1 0 2*10^6]),title('Histogram MFP')
	subplot(313),imhist(Ims),axis tight,title('Masking histogram'),axis([0.9 1 0 2*10^6]),title('Histogram MFP')
end
