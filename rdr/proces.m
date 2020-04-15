clear all
close all
pkg load signal

% Variable to modified
Fs = 4e6; % [Hz]
Fc = 570e6; % [Hz]
MaxDist = 300e3; %  [m]
MaxSpeedKmH = 9e3; % [km/h]

file = fopen('short1023.bin');
temp = fread(file,"int16");
data = temp(1:2:end) + 1i*temp(2:2:end); 

% Variable to calc
Ts = 1/Fs;
c0 = 3e8;
SpaceResolution = Ts * c0; % s = t*v // t = s/v
MaxBins = ceil( MaxDist / SpaceResolution);
MaxSpeedMS = MaxSpeedKmH * 3.6 ; % m/s


length = size(data,1);
n_cycle = 1;


t = 0:Ts:length*Ts;
t = t(1:end-1);
t = t';
f_list = -40:1:40;

fprintf('\nMaximum I : %3.0f, R : %3.0f. \n',max(imag(data)),max(real(data)));


## Plot 
# Spectrum
figure()
pwelch(data,'centerdc');
title('Frequency spectrum')
xlabel('Frequency')
ylabel('Amplitude [dB]')
grid on;
# Xcorr
temp = abs(xcorr(data,data, MaxBins,'none'));
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





for cycle = 1:n_cycle
   iq = double(data(1:end,cycle));
   
   for f_n = 1:numel(f_list)
##      temp = exp(1i*2*pi*f_list(f_n)*t);
      disp(f_list(f_n));
      temp = abs(xcorr(iq,iq .* exp(1i*2*pi*f_list(f_n)*t),MaxBins ,'none'));
      temp = min(MaxLev, max(0,temp));
      temp = log(temp);
      
      len = 400; % time
      n = numel(temp)/2;
      
      temp_short(:,1) = temp( round(n-len) : round (n+len) ,1);
      
      temp_v(:,f_n,cycle) = temp_short;
   end
end

figure()
image(temp_v,'CDataMapping','scaled')