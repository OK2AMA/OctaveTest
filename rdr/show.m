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

function show(conf)
full_filename = [conf.filename, '_temp.mat']
load ("-v6",  full_filename);

out.data = log10(out.data);

% saturate
##out.data = min(15, max(9.5, out.data));
#conf.n_cycle = 1;
figure(1);
for i = 1 : out.conf.n_cycle
image(out.data(:,:,i),'CDataMapping','scaled');
xlabel('Speed')
ylabel('Distance')
title('Passive radar chart.')
pause(1)
end
figure(2)
hist(out.data(:,:,1),100)
end