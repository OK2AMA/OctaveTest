clear all
close all
pkg load signal 

mode = 'both'; 
% proces
% show
% both

##conf.filename = 'short';

%conf.filename = 'short570b'; % short, debug
%conf.DataType = 'FMradio';
%DAB

%conf.filename = 'short762M4'; % short, debug
%conf.DataType = 'DVBT';

%conf.filename = '26k_5_otr'; % short, debug
conf.filename = '5m_26k_8_otr'; % short, debug

conf.DataType = 'DVBT_fs5'; % DVBT_fs26 DVBT_fs5

##conf.filename = 'short762M4';

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