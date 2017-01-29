%{ ----------  Info  ---------- %}
% @date 29-Jan-2017
% @title SEGMENTATION FUNCTION


%% segmentation
function images = segmentation(imagesDir)
	imagesDir = [pwd() imagesDir];
	files = dir([imagesDir '/*.tif']);
	nfiles = length(files);

	images = cell(nfiles/2, 4);
	counter = 1;
	for i = 1:nfiles
		if mod(i, 2) == 0
			file1 = files(i-1).name;
			file2 = files(i).name;

			seg1 = otsu([imagesDir, '/', file1]);
        	seg2 = otsu([imagesDir, '/', file2]);

        	images{counter, 1} = file1;
	        images{counter, 2} = seg1;

	        images{counter, 3} = file2;
	        images{counter, 4} = seg2;
	        counter = counter + 1;
		end
	end
end
