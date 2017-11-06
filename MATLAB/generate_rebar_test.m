%% Rebar - Randomly generate rebar according to spec
% REBAR SPECIFICATIONS
% Size of rebar = between 10mm and 20mm in 1mm sizes (standard specifies
% 10, 12, 16, 20). 1mm for size estimation due to corrosion etc
% Depth of rebar = randomized between 20-100mm (AS:3600 states 15-78mm)
% Rebar spacing = randomized between 100-300mm spacing
% number of rebar = minimum 5, maximum 10 (based on min max spacing)

% Test for rebar drawing
x = imread('template.jpg');
%x = insertShape(x, 'FilledCircle', [250, 110, 20],'Color','red','Opacity', 1 );
%imshow(x);

% #cylinder: 0.225 0.134 0 0.225 0.134 0.002 0.012 rebar
rebar_x = randi([100, 1100])/1000; % in m /1000;
rebar_depth = randi([250-100,250-20])/1000; % in m /1000;
rebar_size = randi([10,20])/2; %in radius /2

generate_rebar = [rebar_x, rebar_depth, 0, rebar_x, rebar_depth, 0.02, rebar_size];
generate_rebar_string = sprintf('#cylinder: %.3f %.3f %.3f %.3f %.3f %.3f %.3f rebar', generate_rebar);

% Starting x distance for randomization
current_distance = 0;
rebar_min_spacing = 100;
rebar_max_spacing = 300;

while current_distance <= 1100
    rebar_x = randi([current_distance + rebar_min_spacing, current_distance + rebar_max_spacing]); % in m /1000;
    rebar_depth_mm = randi([250-100,250-20]);
    rebar_size_mm = randi([10,20])/2; % Radius 
       
    % Update current distance now to allow for rebar domain check
    current_distance = rebar_x;
    
    % Gross but is a break to stop adding rebar once last one is added and
    % is actually outside the domain 
    
    if current_distance > 1100
        break;
    end
    
    % Done before to allow conversion into m from mm
    generate_rebar_real = [(rebar_x-100), (250-rebar_depth_mm), (rebar_size_mm * 2)];
    x = insertShape(x, 'FilledCircle', [(current_distance-100)/2, (250-rebar_depth_mm)/2, rebar_size_mm/2],'Color','red','Opacity', 1 );
    
    % Convert measurements to m. Notw rebar_x chosen so that current
    % distance stays in mm. Lazy - rewrite plz
    rebar_x = rebar_x/1000;
    rebar_depth = rebar_depth_mm/1000;
    rebar_size = rebar_size_mm/1000; 

    
    generate_rebar = [rebar_x, rebar_depth, 0, rebar_x, rebar_depth, 0.002, rebar_size];
    generate_rebar_string = sprintf('#cylinder: %.3f %.3f %.3f %.3f %.3f %.3f %.3f rebar', generate_rebar); 
    
    % Addded as a double check on image pixels to make sure generated
    % correctly
    generate_rebar_convert = sprintf('#cylinder: %d %d %d mm', generate_rebar_real)
end

imshow(x);
%axis on

imwrite(x,'test.png');