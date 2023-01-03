clear
close all
clc

[Name,Path, ~] = uigetfile('*.jpg;*.png');
aI = Name(end-2:end);
for i =1:50
    if strcmp(aI,'jpg')
        name = ['pic(',num2str(i),').jpg'];
    else
        name = ['pic(',num2str(i),').png'];
    end
    M1 = strcat(Path,name);
    MD2{i} = imread(M1);
end
save MelData2