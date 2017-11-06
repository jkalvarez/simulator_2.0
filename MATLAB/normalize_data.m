function [ normalized ] = normalize_data(data)
%% Function takes matrix of values. Returns matrix with values mapped from [-1, 1]
%   maps everything from [0-1]. Multiply by 2, subtract 1.
normalized = mat2gray(data);

% Don't need this bit for the graphical stuff
%normalized = ((normalized*2)-1);  

end

