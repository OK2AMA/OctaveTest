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

function conf = process(conf,data)
pkg load signal

t = 0:conf.Ts : conf.length*conf.Ts;
t = t(1:end-1);
t = t';


for cycle = 1:conf.n_cycle
   iq = double(data(1:end,cycle));

   for f_n = 1:numel(conf.f_list)
##      temp = exp(1i*2*pi*f_list(f_n)*t);
      disp(conf.f_list(f_n));
      temp = abs(xcorr(iq,iq .* exp(1i*2*pi*conf.f_list(f_n)*t),conf.MaxBins ,'none'));
#      temp = min(MaxLev, max(0,temp));
#      temp = log(temp);
      temp_v(:,f_n,cycle) = single(temp);
   end
end

out.conf = conf;
out.data = temp_v;
full_filename = [conf.filename, '_temp.mat']
save ("-v6",  full_filename, "out");

##save(temp_v,'temp_xcorr.mat')

##figure()
##image(temp_v,'CDataMapping','scaled')
end 