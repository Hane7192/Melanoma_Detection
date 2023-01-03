clear
close all
clc

load MelData1
load MelData2
load nonMelData1
load nonMelData2
index = 50;
%% Extracting Melanoma Features
for i = 1:index
%     if i==19
%         continue;
%     end
    pic1 = MD1{i};
    im1  = MD2{i};
    Temp = double(rgb2gray(pic1));
    data{i} = Temp.*double(im1);
    % Feature 1  Mean of Skin Lesion
    A = size(find(data{i}),1);
    B = sum(sum(data{i}));
    data_mean{i} = A/B;
    % Feature 2  Variance of Skin Lesion
    data_var{i} = sum(sum((data{i}-data_mean{i}).^2));
    % Feature 3 Skin Lesion Major Axis Length
    MA{i} = regionprops(MD2{i},'MajorAxisLength');
    % Feature 4 Skin Lesion Minor Axis Length
    mA{i} = regionprops(MD2{i},'MinorAxisLength');
    % Feature 5 Skin Lesion Roundness
    PP = regionprops(MD2{i},'Perimeter');
    AA = regionprops(MD2{i},'Area');
    Rness{i} = 4*pi.*(AA.Area)./((PP.Perimeter)^2);
end

%% Extracting nonMelanoma Features
for i = 1:index
    pic1 = nMD1{i};
    im1  = nMD2{i};
    Temp = double(rgb2gray(pic1));
    ndata{i} = Temp.*double(im1);
    % Feature 1  Mean of Skin Lesion
    A = size(find(data{i}),1);
    B = sum(sum(data{i}));
    ndata_mean{i} = A/B;
    % Feature 2  Variance of Skin Lesion
    ndata_var{i} = sum(sum((data{i}-data_mean{i}).^2));
    % Feature 3 Skin Lesion Major Axis Length
    nMA{i} = regionprops(nMD2{i},'MajorAxisLength');
    % Feature 4 Skin Lesion Minor Axis Length
    nmA{i} = regionprops(nMD2{i},'MinorAxisLength');
    % Feature 5 Skin Lesion Roundness
    PP = regionprops(nMD2{i},'Perimeter');
    AA = regionprops(nMD2{i},'Area');
    nRness{i} = 4*pi*AA.Area/PP.Perimeter^2;
end

save Features