
% setup 
workingDir = tempname;
mkdir(workingDir)
mkdir(workingDir,'images')

%create video recorder
shuttleVideo = VideoReader('shuttle.mp4');

%find image sequence
ii = 1;

while hasFrame(shuttleVideo)
   img = readFrame(shuttleVideo);
   filename = [sprintf('%03d',ii) '.jpg'];
   fullname = fullfile(workingDir,'images',filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end

%find image file names
imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = dir(fullfile('Cell Line Time Lapse','*.jpg'));
imageNames = {imageNames.name}';

%create new video with image sequence
outputVideo = VideoWriter(fullfile(workingDir,'shuttle_out.mp4'));
outputVideo.FrameRate = shuttleVideo.FrameRate;
open(outputVideo)

for ii = 1:length(imageNames)
   img = imread(fullfile('Cell Line Time Lapse',imageNames{ii}));
   writeVideo(outputVideo,img)
end
close(outputVideo)

%view the final video
shuttleAvi = VideoReader(fullfile(workingDir,'shuttle_out.mp4'));
f = figure;
f.Position = [150 150 shuttleAvi.Width shuttleAvi.Height];
ax = gca; ax.Units = 'pixels'; ax.Position = [0 0 shuttleAvi.Width shuttleAvi.Height];
%image(mov(1).cdata,'Parent',ax) 
axis off
movie(mov,1,shuttleAvi.FrameRate)

