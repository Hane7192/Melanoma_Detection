clc;
clear all;
close all;
%% Initialization
load my_network

%% Reading Images
[Name,Path, ~] = uigetfile('*.jpg');
M1             = strcat(Path, Name);
index          = length(Name);
Name_new       = strcat(Name(1:index-8),'contour.png');
M2             = strcat(Path,Name_new);
pic_o          = imread(M1);

%% Image Modification
pic = rgb2hsv(pic_o);
subplot(1,2,1),imshow(pic_o,[])
subplot(1,2,2),imshow(pic(:,:,1),[])

%% Image Segmentation

H = pic(:,:,1);
h = fspecial('gaussian', 20);
pic2 = imfilter(H,h);
pic2 = abs((pic2 - min(min(pic2)))./max(max(pic2))*255);
figure
imhist(uint8(pic2))
figure
pic2(pic2<50) = 0;
pic2(pic2>=50) = 1;
SE1=strel('disk',30,0);
IM2 = imopen(pic2,SE1);
BW2 = imfill(IM2);
imshow(BW2,[]) , title('Segmented Picture')

%% Extracting Melanoma Features

pic1 = pic_o;
im1  = pic2;
Temp = double(rgb2gray(pic1));
data = Temp.*double(im1);
% Feature 1  Mean of Skin Lesion
A = size(find(data),1);
B = sum(sum(data));
data_mean = A/B;
% Feature 2  Variance of Skin Lesion
data_var = sum(sum((data-data_mean).^2));
% Feature 3 Skin Lesion Major Axis Length
MA = regionprops(BW2,'MajorAxisLength');
% Feature 4 Skin Lesion Minor Axis Length
mA = regionprops(BW2,'MinorAxisLength');
% Feature 5 Skin Lesion Roundness
PP = regionprops(BW2,'Perimeter');
AA = regionprops(BW2,'Area');
Rness = 4*pi.*(AA.Area)./((PP.Perimeter)^2);

T_Data(1,1) = data_mean;
T_Data(2,1) = data_var;
T_Data(3,1) = MA.MajorAxisLength;
T_Data(4,1) = mA.MinorAxisLength;
T_Data(5,1) = Rness;

y = net(T_Data)

if y(1) > 0
    disp('nonMelanoma')
else
    disp('Melanoma')
end