function [ field value rebar] = in_file_info(fname)
%% Gets information from an .in file for gprMax
%   syntax: infos = in_file_info(fname,param1,param2,....)

%%
% numargcount=size(varargin,2);
% 
% [field,value]=textread(fname,'%s:%s','whitespace',':\n', 'headerlines',1);
% 
% for i=1:numargcount
%     param=varargin{i};
%     infos{i}=getproperty(param,field,value);
% end
% 
% 
% 
% function propvalue=getproperty(propname,fields,values)
% 
% for l=1:size(fields,1)
%    if (strcmpi(fields{l},propname))
%       propvalue=values{l};
%    end
% end
%
% a=sscanf(propvalue,'%f');
% if (size(a,2)~=0)
%    propvalue=a;
% end

%%
[field,value]=textread(fname,'%s:%s','whitespace',':\n', 'headerlines',1);

%% hack for now due to time, generalise later
% find rebars and create matrix of size, location

rebar = getproperty('#cylinder', field, value);

function propvalue=getproperty(propname,fields,values)

for i=1:size(fields,1)
   if (strcmpi(fields{i},propname))
      propvalue = values{i};
   end
end

a=sscanf(propvalue,'%f');
if (size(a,2)~=0)
   propvalue=a;
end
