function W = AbsWinding(data)
%% Calculate winding numbers of a parametric curve
% Input: data matrices with three columns:
%        1-st colum = time
%        2-nr colume = x-coordinate
%        3-rd colume = y-coordinate
% Output: Absolute winding number
%
% Created by: Didong Li on August. 2, 2020
% Modified by: Didong Li on August. 7, 2020

%data = TestFiles;
W = 0;
[n,~] = size(data);
for i = 1:n-2
    vec_curr = data(i+1,2:3)-data(i,2:3); %tangent vector at the current position
    vec_next = data(i+2,2:3)-data(i+1,2:3); %tangent vector at the next position
    CosTheta = max(min(dot(vec_curr,vec_next)/(norm(vec_curr)*norm(vec_next)),1),-1); %inner product
    Theta = real(acos(CosTheta)); %angle between two tangent vectors
    W = W+abs(Theta); % accumulate absolute angles
end

W = W/(2*pi); %divided by 2*pi
%plot(data(:,2),data(:,3))

return