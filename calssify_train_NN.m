close all
clear
clc
%% Input Data Definition
load Features

%% Making Lables for Train & Test Data
TrainL = ones(2,100);
TrainL(1,1:50) = -1;
TrainL(2,51:100) = -1;
for i = 1:50
    TrainData(1,i) = data_mean{i};
    TrainData(2,i) = data_var{i};
    TrainData(3,i) = MA{i}.MajorAxisLength;
    TrainData(4,i) = mA{i}.MinorAxisLength;
    TrainData(5,i) = Rness{i};
end
for i = 51:100
    TrainData(1,i) = ndata_mean{i-50};
    TrainData(2,i) = ndata_var{i-50};
    TrainData(3,i) = nMA{i-50}.MajorAxisLength;
    TrainData(4,i) = nmA{i-50}.MinorAxisLength;
    TrainData(5,i) = nRness{i-50};
end

%% Network Initialization
itteration  = 50;
hidden_neuron = 8;
net = newff (TrainData, TrainL , hidden_neuron);
net.divideParam.trainRatio = 0.1;
net.trainParam.epochs = itteration;
net.divideParam.valRatio = 0;
net.divideParam.testRatio = 0;
net.trainParam.min_grad = 0;
%% Training & Testing Network
[net,tr,Y,E]    = train(net,TrainData,TrainL);
save my_netwotk net