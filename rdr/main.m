clear all
close all
pkg load signal

mode = 'show'; 
% proces
% show
% both

##conf.filename = 'short';
##conf.lename = 'short570b';
conf.filename = 'short762M4';

% Define conditions  
[conf, data] = init(conf);

%% Process
if ( strcmp(mode,'process') || strcmp(mode,'both') )
  
process(conf, data)
clear data
end
%% Show
if ( strcmp(mode,'show') || strcmp(mode,'both') )
  
show(conf)

end