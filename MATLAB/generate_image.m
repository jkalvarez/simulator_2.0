%% Function generates png images based on testID parameters. 
% File name of image data first, then the raw data from the gprMax output
% as mat file

% random_permutation is an array of random unique values which are used to
% shuffle and name the files.

function [] = generate_image(numberID)

%% Load gpr data and ground truth image via ID
image_filename = sprintf('./permittivity_map_images/logit_scaled/gt%d.png', numberID);

% comment out line below to load old version with text file output
data_filename = sprintf('./gprMax_output/sim%d.txt', numberID);
%data_filename = sprintf('./gprMax_output/sim%d_merged.out', numberID);

x = imread(image_filename);
% comment out line below to load old version with text file output
data = importfile(data_filename);


% Load HDF5 file
% data = hdf5read(data_filename, 'rxs/rx1/Ez');
% data = double(data)';

%x = repmat(x, [1 1 3]);
 
%% Process the gpr data as required
gprMaxData = process_gprMax_data(data);
% Only for sim0
%gprMax_image = repmat(gprMaxData,[1 1 3]);
gprMax_image = gprMaxData;

%% Display images are loaded and double check
figure
imshow(x);

figure
imshow(gprMax_image);

%% Proved that we could load and process the images. Now sub window them to 125x125 and join
% Not that important but out of convention use gpr|ground_truth
% Use a | b terminology used in pix2pix. c is resultant image.

% Control the stride of the sliding window operation
stride = 40;
[~, width, ~] = size(x);
stride_end = width-125;

% Starting image number. Used for creating image file names that don't
% start at 1
j = 241;

for i=1:stride:4800
    a = imcrop(gprMax_image,[i 1 125 125]);
    b = imcrop(x,[i 1 125 125]);
    
    %Image concatenation
    c = [a b];
    combined_filename = sprintf('./combined_images/val/%d.png', j);
    imwrite(c, combined_filename);
    
    j = j + 1;

end


%figure
%imshow(c);
 