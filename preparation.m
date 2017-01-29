%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title PREPARATION

clear; close all; clc;

basename = '/';
datasetdir = [basename 'datasets/'];
matdir = 'mats/';
addpath('codes/');

%% Colorcharts to LAB
disp('START: convert colorcharts rgb to l*a*b*');
dirname = [datasetdir 'colorcharts/'];
l_a_b_colorcharts = lab(dirname);
disp('SAVING: results into mats/l_a_b_colorcharts.mat');
save([matdir 'l_a_b_colorcharts.mat'], 'l_a_b_colorcharts');
disp('***END***');

%% The transformation model on colorcharts
disp('START: the transformation model on colorcharts');
data = load([matdir 'l_a_b_colorcharts.mat']);
data = data.l_a_b_colorcharts;
[netL, netA, netB, perf] = ann(data);
disp(['ANN PERFORMANCE: ' 'net(L)= ' num2str(perf(1)) ' net(A)= ' num2str(perf(2)) ' net(B)= ' num2str(perf(2))]);
disp('SAVING: results into mats/netL.mat');
save([matdir 'netL.mat'], 'netL', '-v7.3');
disp('SAVING: results into mats/netA.mat');
save([matdir 'netA.mat'], 'netA', '-v7.3');
disp('SAVING: results into mats/netB.mat');
save([matdir 'netB.mat'], 'netB', '-v7.3');
disp('***END***');


%% Coffeebeans whitish segmentation
disp('START: coffeebeans whitish segmentation');
dirname = [datasetdir 'whitish/'];
whitish = segmentation(dirname);
disp('SAVING: results into mats/whitish.mat');
save([matdir 'whitish.mat'], 'whitish', '-v7.3');
disp('***END***');

%% Coffeebeans green segmentation
disp('START: coffeebeans green segmentation');
dirname = [datasetdir 'green/'];
green = segmentation(dirname);
disp('SAVING: results into mats/green.mat');
save([matdir 'green.mat'], 'green', '-v7.3');
disp('***END***');

%% Coffeebeans cane_green segmentation
disp('START: coffeebeans cane_green segmentation');
dirname = [datasetdir 'cane_green/'];
cane_green = segmentation(dirname);
disp('SAVING: results into mats/cane_green.mat');
save([matdir 'cane_green.mat'], 'cane_green', '-v7.3');
disp('***END***');

%% Coffeebeans bluish_green segmentation
disp('START: coffeebeans bluish_green segmentation');
dirname = [datasetdir 'bluish_green/'];
bluish_green = segmentation(dirname);
disp('SAVING: results into mats/bluish_green.mat');
save([matdir 'bluish_green.mat'], 'bluish_green', '-v7.3');
disp('***END***');