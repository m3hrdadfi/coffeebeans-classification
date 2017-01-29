%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title ANN FUNCTION

%% ann
function [netL, netA, netB, perf] = ann(data)
	%% NET INIT
	dataSize = size(data, 1);
	idxPerm = randperm(dataSize);
	trainRate = 0.8;
	trainSize = round(trainRate * dataSize);

	Train = data(idxPerm(1:trainSize), :);
	X = cell2mat(Train(:, 3));
	T = (cell2mat(Train(:, 4)));

	Test = data(idxPerm(trainSize:end), :);
	Xtest = cell2mat(Test(:, 3));
	Ttest = (cell2mat(Test(:, 4)));

	%% NET CONFIG
	hiddenSizes = 5;
	trainFcn = 'trainlm';
	showWindow = false;
	trainEpochs = 500;
	trainGoal = 1e-12;
	performFcn = 'mse';

	RGB = X';
	TL = T(:, 1)';
	TA = T(:, 2)';
	TB = T(:, 3)';

	RGBtest = Xtest';
	TLtest = Ttest(:, 1)';
	TAtest = Ttest(:, 2)';
	TBtest = Ttest(:, 3)';

	%% NET L START & RESULTS
	netL = feedforwardnet(hiddenSizes, trainFcn);
	netL.trainParam.showWindow = showWindow;
	netL.trainParam.epochs = trainEpochs;
	netL.trainParam.goal = trainGoal;
	netL.performFcn = performFcn;
	netL = train(netL, RGB, TL);

	YLtest = netL(RGBtest);
	perfL = perform(netL, TLtest, YLtest)

	%% NET A START & RESULTS
	netA = feedforwardnet(hiddenSizes, trainFcn);
	netA.trainParam.showWindow = showWindow;
	netA.trainParam.epochs = trainEpochs;
	netA.trainParam.goal = trainGoal;
	netA.performFcn = performFcn;
	netA = train(netA, RGB, TA);

	YAtest = netA(RGBtest);
	perfA = perform(netA, TAtest, YAtest)

	%% NET B START & RESULTS
	netB = feedforwardnet(hiddenSizes, trainFcn);
	netB.trainParam.showWindow = showWindow;
	netB.trainParam.epochs = trainEpochs;
	netB.trainParam.goal = trainGoal;
	netB.performFcn = performFcn;
	netB = train(netB, RGB, TB);

	YBtest = netB(RGBtest);
	perfB = perform(netB, TBtest, YBtest)

	%% Performs
	perf = [perfL, perfA, perfB];
end
