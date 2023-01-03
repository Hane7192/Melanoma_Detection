clear
close all
clc
%% Initialization
radius = 5;
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
imshow(pic2,[]) , title('Segmented Picture')
