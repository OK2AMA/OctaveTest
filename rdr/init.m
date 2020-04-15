## Copyright (C) 2020 jakub
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} initt (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: jakub <jakub@kubax220>
## Created: 2020-04-15

function [conf, data] = init (conf)

% Variable to modified
conf.Fs = 4e6; % [Hz]
conf.Fc = 570e6; % [Hz]
conf.MaxDist = 300e3; %  [m]
conf.MaxSpeedKmH = 9e3; % [km/h]

full_filename = [conf.filename, '.bin']
file = fopen(full_filename);
temp = fread(file,"int16");
data = temp(1:2:end) + 1i*temp(2:2:end); 


% Variable to calc
conf.Ts = 1/conf.Fs;
conf.c0 = 3e8;
conf.SpaceResolution = conf.Ts * conf.c0; % s = t*v // t = s/v
conf.MaxBins = ceil( conf.MaxDist / conf.SpaceResolution);
conf.MaxSpeedMS = conf.MaxSpeedKmH * 3.6 ; % m/s


conf.length = size(data,1);
conf.n_cycle = 1;


conf.f_list = -80:1:80;

fprintf('\nMaximum I : %3.0f, R : %3.0f. \n',max(imag(data)),max(real(data)));

if 0
## Plot 
# Spectrum
figure()
pwelch(data,'centerdc');
title('Frequency spectrum')
xlabel('Frequency')
ylabel('Amplitude [dB]')
grid on;
# Xcorr
temp = abs(xcorr(data,data, conf.MaxBins,'none'));
figure;
plot(temp);
grid on
xlabel('Distance')
ylabel('Amplitude')
title('Autocorelation')
i=numel(temp)/4;
MaxLev = mean(temp(i-20:i+20))*4;
# Histogram
figure;
hist(real(data(1:1e4)),20);
grid on
xlabel('Value')
ylabel('Occurencies')
title('Histogram of real value')
end 


end

