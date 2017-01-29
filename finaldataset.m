%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title COFFEEBEANS FINAL DATASET

clear; close all; clc;
matdir = 'mats/';
addpath('codes/');

%% LOAD MAT FILES
load([matdir 'whitish.mat']);
load([matdir 'green.mat']);
load([matdir 'cane_green.mat']);
load([matdir 'bluish_green.mat']);

load([matdir 'netL.mat']);
load([matdir 'netA.mat']);
load([matdir 'netB.mat']);

whitishFront = whitish(:, 2);
whitishBack = whitish(:, 4);
whitishSize = size(whitish, 1);

greenFront = green(:, 2);
greenBack = green(:, 4);
greenSize = size(green, 1);

caneGreenFront = cane_green(:, 2);
caneGreenBack = cane_green(:, 4);
caneGreenSize = size(cane_green, 1);

bluishGreenFront = bluish_green(:, 2);
bluishGreenBack = bluish_green(:, 4);
bluishGreenSize = size(bluish_green, 1);

coffeebeansRows = whitishSize + greenSize + caneGreenSize + bluishGreenSize;
coffeebeans = cell(coffeebeansRows, 7);
cls = {'whitish', 'green', 'cane_green', 'bluish_green'};

%% ANN WHITISH
WRGB1 = ones(size(whitishFront, 1), 3);
WRGB2 = ones(size(whitishBack, 1), 3);
for i = 1:size(whitishFront, 1)
    WRGB1(i, :) = mean(mean(whitishFront{i}));
    WRGB2(i, :) = mean(mean(whitishBack{i}));
end
WRGB1 = WRGB1';
WRGB2 = WRGB2';

WLAB1 = [netL(WRGB1); netA(WRGB1); netB(WRGB1)]';
WLAB2 = [netL(WRGB2); netA(WRGB2); netB(WRGB2)]';

coffeebeans(1:whitishSize, 1:4) = whitish;
for i = 1:whitishSize
    md = mod(i, whitishSize);
    if md == 0
        coffeebeans(i, 5) = mat2cell(WLAB1(whitishSize, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(WLAB2(whitishSize, :), 1, 3);
    else
        coffeebeans(i, 5) = mat2cell(WLAB1(md, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(WLAB2(md, :), 1, 3);
    end
end
coffeebeans(1:whitishSize, 7) = cls(1);

%% ANN GREEN
GRGB1 = ones(size(greenFront, 1), 3);
GRGB2 = ones(size(greenBack, 1), 3);
for i = 1:size(greenFront, 1)
    GRGB1(i, :) = mean(mean(greenFront{i}));
    GRGB2(i, :) = mean(mean(greenBack{i}));
end
GRGB1 = GRGB1';
GRGB2 = GRGB2';

GLAB1 = [netL(GRGB1); netA(GRGB1); netB(GRGB1)]';
GLAB2 = [netL(GRGB2); netA(GRGB2); netB(GRGB2)]';

from = whitishSize+1;
to = whitishSize+greenSize;
coffeebeans(from:to, 1:4) = green;
for i = from:to
    md = mod(i, to-from+1);
    if md == 0
        coffeebeans(i, 5) = mat2cell(GLAB1(to-from+1, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(GLAB2(to-from+1, :), 1, 3);
    else
        coffeebeans(i, 5) = mat2cell(GLAB1(md, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(GLAB2(md, :), 1, 3);
    end
end
coffeebeans(from:to, 7) = cls(2);

%% ANN CANEGREEN
CRGB1 = ones(size(caneGreenFront, 1), 3);
CRGB2 = ones(size(caneGreenBack, 1), 3);
for i = 1:size(caneGreenFront, 1)
    CRGB1(i, :) = mean(mean(caneGreenFront{i}));
    CRGB2(i, :) = mean(mean(caneGreenBack{i}));
end
CRGB1 = CRGB1';
CRGB2 = CRGB2';

CLAB1 = [netL(CRGB1); netA(CRGB1); netB(CRGB1)]';
CLAB2 = [netL(CRGB2); netA(CRGB2); netB(CRGB2)]';

from = to+1;
to = to+caneGreenSize;
coffeebeans(from:to, 1:4) = cane_green;
for i = from:to
    md = mod(i, to-from+1);
    if md == 0
        coffeebeans(i, 5) = mat2cell(CLAB1(to-from+1, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(CLAB2(to-from+1, :), 1, 3);
    else
        coffeebeans(i, 5) = mat2cell(CLAB1(md, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(CLAB2(md, :), 1, 3);
    end
end
coffeebeans(from:to, 7) = cls(3);

%% ANN BLUISHGREEN
BRGB1 = ones(size(bluishGreenFront, 1), 3);
BRGB2 = ones(size(bluishGreenBack, 1), 3);
for i = 1:size(bluishGreenFront, 1)
    BRGB1(i, :) = mean(mean(bluishGreenFront{i}));
    BRGB2(i, :) = mean(mean(bluishGreenBack{i}));
end
BRGB1 = BRGB1';
BRGB2 = BRGB2';

BLAB1 = [netL(BRGB1); netA(BRGB1); netB(BRGB1)]';
BLAB2 = [netL(BRGB2); netA(BRGB2); netB(BRGB2)]';

from = to+1;
to = to+bluishGreenSize;
coffeebeans(from:to, 1:4) = bluish_green;
for i = from:to
    md = mod(i, to-from+1);
    if md == 0
        coffeebeans(i, 5) = mat2cell(BLAB1(to-from+1, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(BLAB2(to-from+1, :), 1, 3);
    else
        coffeebeans(i, 5) = mat2cell(BLAB1(md, :), 1, 3);
        coffeebeans(i, 6) = mat2cell(BLAB2(md, :), 1, 3);
    end
end
coffeebeans(from:to, 7) = cls(4);

%% SAVE COFFEEBEANS FINAL DATASET
save([matdir 'coffeebeans.mat'], 'coffeebeans', '-v7.3');