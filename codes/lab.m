%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title RGB 2 LAB FUNCTION

%% lab
function l_a_b = lab(imagesDir)
	imagesDir = [pwd() imagesDir];
	files = dir([imagesDir '*.tif']);
	nfiles = length(files);
	l_a_b = cell(nfiles, 4);

	for i = 1:nfiles
		file = files(i).name;
		
		im = imread([imagesDir file]);
		im_mean = mean(mean(im));

		lab = rgb2lab(im);
		lab_mean = mean(mean(lab));

		l_a_b{i, 1} = file;
	    l_a_b{i, 2} = im;
	    l_a_b{i, 3} = im_mean(:)';
	    l_a_b{i, 4} = lab_mean(:)';
	end
end
