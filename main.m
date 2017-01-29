%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title CLASSIFICATION & RECOGNITION

clear; close all; clc;
matdir = 'mats/';
addpath('codes/');

%% LOAD COFFEEBEANS DATASET
dataset = load([matdir 'coffeebeans.mat']);
dataset = dataset.coffeebeans;
datasetSize = size(dataset);

%% TRAIN INIT
idxPerm = randperm(datasetSize(1));
trainRate = 0.8;
trainSize = round(trainRate * datasetSize(1));

Train = dataset(idxPerm(1:trainSize), :);
XFront = cell2mat(Train(:, 5));
XBack = cell2mat(Train(:, 6));
T = Train(:, 7);

%% TEST INIT
Test = dataset(idxPerm(trainSize:end), :);
XtestFront = cell2mat(Test(:, 5));
XtestBack = cell2mat(Test(:, 6));
Ttest = Test(:, 7);

%% Naive Bayes Classifier
cls = {'whitish', 'green', 'cane_green', 'bluish_green'};
bcFront = fitcnb(XFront, T, 'ClassNames', cls);
bcBack = fitcnb(XBack, T, 'ClassNames', cls);

ZFront = predict(bcFront, XtestFront);
ZBack = predict(bcBack, XtestBack);
ZZ = cell(size(ZFront, 1), 3);

ZZ(:, 1) = Ttest;
ZZ(:, 2) = ZFront;
ZZ(:, 3) = ZBack;

CMF = confusionmat(Ttest, ZFront);
CMB = confusionmat(Ttest, ZBack);

disp('Confusion Matrix Front:');
disp(CMF);
disp('Confusion Matrix Back:');
disp(CMB);

