clear all
close all
pkg load signal

mode = 'both'; 
% proces
% show
% both

conf.filename = 'short570';

% Define conditions  
[conf, data] = init(conf);

%% Process
if ( strcmp(mode,'process') || strcmp(mode,'both') )
  
process(conf, data)

end

%% Show
if ( strcmp(mode,'show') || strcmp(mode,'both') )
  
show(conf)

end