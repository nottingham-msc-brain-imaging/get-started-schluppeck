function [ h ] = arrayview( data )
%arrayview - simple array viewer for 3d data - some comment
%
%      usage: [ h ] = arrayview( data )
%         by: ds1
%       date: 2018-11. set up for 2018/19 assignment
%     inputs: data - 3d or 4d array of data
%                    if 3d array, the viewer program displays as is
%                    if 4d array, the viewer programm displays mean of data
%                                 across the fourth dimension
%
%    outputs: h - graphics handle to figure (so it can be closed again easily)
%
%    purpose: a simple window/function that can be used to visualise a data 
%             set and allows you to flip through slices (+ orientations) 
%
%        e.g: threeDdata = rand(50,75,100); % a 3d cube of random data
%             fourDdata = niftiread('dafni_test.nii'); % fMRI data
%
%             h1 = arrayview(threeDdata)
%             h2 = arrayview(fourDdata)

% print some information on the command line
% that helps the user

disp('==============================================')
fprintf('\tarrayview() program - 2018 assignment\n\n\n')
fprintf('\tPress the following buttons to:\n')
fprintf('up/down\tchange slice\n')
fprintf('o/O\t\tchange orientation\n')
fprintf('c/C\t\tchange cursor\n')
fprintf('q/Esc\t\tquit\n')
disp('==============================================')

%% ASSIGNMENT: 

% 1. write some code the checks the dimensions of the input argument
%
%     if the data are 3d, then use them as they are
%     if the data are 4d, then take the mean across "time"
%     if the data are neither of those, e.g. 2d or 5d, display an error
%        message
%
% ! comment your code to explain your thinking





%% no need to touch code below here...
%
% open a new figure window
h = figure(); % call figure like this, then matlab makes a new window

% change the name of the figure to reflect the image we are looking at
set(h,'Name', 'arrayview() - 2018 assignment');

% the following hooks up several other functions that get triggered/executed
% when different events happen: e.g. a keypress, mouse click, scroll, etc

set(h,'KeyPressFcn',@keypress);
set(h,'toolbar','none');

%%
%
% have a function that returns a slice in a particular orientation?
% start with "it would be really great to have a function that does X"
% and then just do/implement it

% decide which dimension we want to keep fixed. we'll call this the
% "orientation" of the image.
orientation = 1; % could be 1, 2, or 3
sliceNum = round(size(data, orientation)./2); % half way through the stack in particular orientation
s = returnSlice(data, sliceNum, orientation); % now grab a slice

% keep everything that we want to pass round neatly wrapped up in a
% STRUCTURE called "data"

displayData = struct('array', data, 'currentSliceNum', sliceNum, ...
    'currentOrientation', orientation, 'currentSlice', s);

% fix the colormap and the range of values
displayData.cmap = gray(256);
displayData.dataLimits = prctile(data(:),[5 95]);

% attach the wrapped up "data" to the window (handle)
set(h,'UserData',displayData);

% now for the first time, draw the slice now:
drawSlice(h);

end


% function returnSlice -- has to be completed!


function keypress(h,evnt)
% keypress - gets called every time a key is pressed

% get hold of the data for use in this function...
data=get(h,'UserData');

% disp('Pressed a key')
switch evnt.Key
    case 'uparrow'
        data.currentSliceNum = data.currentSliceNum + 1;
    case 'downarrow'
        data.currentSliceNum = data.currentSliceNum - 1;
    case {'c','C'}
        % NINJA skill
        % toggle between crosshair / arrow (if it's not already in that
        % state
        if ~strcmp(get(h,'Pointer'),'crosshair')
            set(h,'Pointer','crosshair');
        else
            set(h,'Pointer','arrow');
        end
    case {'o','O'}  
        % NINJA skill
        % change orientation... 
        % mod(currentOrientation,3) is the remainder after division with 3,
        % so this means that we never get bigger than 3. One thing to keep
        % in mind here is that mod(x,3) returns 0, 1, 2, 0, 1, 2... so we
        % need to add 1 to make is consistent with our way of counting
        % orientation.
        %
        % help mod     
        data.currentOrientation = mod(data.currentOrientation + 1,3) + 1;
    case {'Q','q','escape'}
        disp('Byebye!')
        close(h); 
        return;
end

% check that we don't go under 0 or over the max
if data.currentSliceNum < 1
    % warn the user
    disp('(keypress) UHOH! trying to go below 0!')
    data.currentSliceNum = 1;
end
% also need to check about the max values don't go over the maximum extent
% in that orientation. my solution: set it to the max (and stop going
% higher)

if data.currentSliceNum > size(data.array, data.currentOrientation)
    data.currentSliceNum = size(data.array, data.currentOrientation);
    disp('(uhoh) had to reset slicenumber when switching orientation')
end

% now also need to put the new slice image into its place
data.currentSlice = returnSlice(data.array, ...
    data.currentSliceNum, ...
    data.currentOrientation);

% pack it up for return by the function
set(h,'UserData',data);

% and draw the new slice
drawSlice(h);

end


function drawSlice(h)
% drawSlice - draws the current slice in the window

figure(h)
% get a local copy of the data 
data = get(h,'UserData');
img = data.currentSlice;

% display (with a particular range, to make sure the colors don't "jump"
% around
imagesc(img, data.dataLimits);
colormap(data.cmap)
cb_ = colorbar;
cb_.Label.String = 'Image intensity (au)';
axis image
axis ij

% add a text label:
t_ = text(0,0,['Slice: ' num2str(data.currentSliceNum, '%d') ] );
set(t_, 'color','w', 'backgroundcolor', [1,0.5, 0.5, 0.5], ...
    'fontsize',24, 'fontweight', 'bold', 'verticalalignment','top', ...
    'horizontalalignment','left');
end




