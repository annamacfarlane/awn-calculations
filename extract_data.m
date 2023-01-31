%% Calculate Absolute Winding Numbers from mice trajectory data
% Output: Absolute winding numbers (AWN)
%
% Created by: Didong Li on August. 2, 2020
% Modified by: Didong Li on August. 7, 2020


clear
close all
warning('off','all')


% you may change the directory. this directory should contain the following:
% 1. function AbsWinding.m
% 2. extract_data.m (this file)
% 3. Any folder of interest, containing some .csv files with mice trajectory


cd /Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/

% folder name
file_name = 'TestFiles';

% all files in the folder
Files = dir(file_name);

% There are 2 NA rows in each file so there are N-2 files in each folder
rownames = {};  % rownames
N = length(Files)-2; % number of files in each folder
Winding_numbers = zeros(N-2,1); % array storing AWN

for k=3:length(Files)
   name = Files(k).name;  % read each file in the folder
   rownames = [rownames, name]; % store rownames
   
   % change directory to the folder of interest so that we can read each .csv file inside the folder
   
   cd /Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/TestFiles/

   % table storing the name 
   table = readtable(name);
   %test= table2array(table);
   %plot(test(:,2),test(:,3))
   [n,~] =size(table);
   data = zeros(n-1,3); % intialize data matrix containing time, x and y coordinate of the mouse at time t
   for i = 2:n
       t = table(i,1);
       t = table2array(t); % convert the first column of the table (time t) to array
       
       % convert HH:MM:SS.SSSS to total number of seconds
       [H1, H2, M1, M2, S1, S2] = datevec(t); 
       data(i-1,1) = (10*H1+H2)*3600+(10*M1+M2)*60+10*S1+S2;
       
       % extract 2-3 columns to data matrix, representing x and y coordinates
       data(i-1,2:3) = table2array(table(i,2:3));
   end
   
   % change directory back to the parent folder with file 'AbsWinding.m'
   cd /Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/Winding/
   Winding_numbers(k-2,1) = AbsWinding(data);   % calculate the AWN from coordinates-matrix 'data'
   
   % you can display the AWN of the current file, with file index to check the status
   display([num2str(k-2),'-th file: ', 'Absolute Winding Number = ', num2str(Winding_numbers(k-2,1))])
end



% change row to column
rownames=rownames.';

% storre all necessary information to a N by 1 table. Each entry is the AWN of a .csv file, 
% which name matches the rowname before it

AWN = array2table(Winding_numbers, 'RowNames',rownames);

% You may save the above AWN table to a new .csv file, with name matches
% the name of the folder of interests, if not you can save AWN by yourself

cd /Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/Winding/
 writetable(AWN,'JoanMWM_positions.csv','WriteRowNames',true)



% you may also plot the trajectories of two mice with the largest and
% smallest AWN within the folder. If not you can comment out all below
% lines.


cd /Users/AnnaMacFarlane/Documents/MATLAB/JoanMWM/TestFiles/

% find nonzero AWN, since there are some NA files with zero AWN (does not
% make any sense).
non_zero = find(Winding_numbers>0);

% find the coordinates of the mouth with the smallest AWN and plot the
% trajetory
ind_min = min(find(Winding_numbers(non_zero) == min(Winding_numbers(non_zero))));
name_min = Files(ind_min+2).name; 
table_min = readtable(name_min);
table_min = table2array(table_min);
subplot(1,2,1)
plot(table_min(:,2),table_min(:,3))
title('Trajactory with the smallest AWN')

% find the coordinates of the mouth with the largest AWN and plot the
% trajetory
ind_max = max(find(Winding_numbers == max(Winding_numbers)));
name_max = Files(ind_max+2).name; 
table_max = readtable(name_max);
table_max = table2array(table_max);
subplot(1,2,2)
plot(table_max(:,2),table_max(:,3))
title('Trajactory with the largest AWN')


