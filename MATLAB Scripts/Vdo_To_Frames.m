obj = VideoReader('Multiple_Folds3.avi');
vid = read(obj);
frames = obj.NumberOfFrames;
for x = 1 : frames
    imwrite(vid(:,:,:,x),strcat('multiplefolds3---',num2str(x),'.png'));
end