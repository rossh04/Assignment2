%Holly Ross
%September 13, 2017
%Assigment 02
%Plotting different balls being thrown in the air

close all; clear all; clc;

 StartingFrame = 1;
 EndingFrame = 449;
 
 Xcentroid = [];
 Ycentroid = [];
 
 XcentroidGreen = [];
 YcentroidGreen = [];
 
 
 
 for k = StartingFrame : EndingFrame - 1
     
    rgb = imread(['img' sprintf('%2.3d',k),'.jpg']);
    
    BW = createMask(rgb);
    BWGreen = createMask2(rgb);
 
    
    SE = strel('disk',5,0);
    BW1 = imopen(BW, SE);
    BW2 = imclose(BW1, SE);
    
    BWGreen1 = imopen(BWGreen, SE);
    BWGreen2 = imclose(BWGreen1, SE);

    %Code to plot the blue ball
    [labels, number] = bwlabel(BW2,8);
    
    if number > 0
        Istats = regionprops(labels, 'basic', 'Centroid');
        [maxVal, maxIndex] = max([Istats.Area]); 
    
    Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
    Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
    end
 
    %Code to plot the small green balls
        [labelsGreen, numberGreen] = bwlabel(BWGreen2,8);
    
    if numberGreen > 0
        IstatsGreen = regionprops(labelsGreen, 'basic', 'Centroid');
        [maxValGreen, maxIndexGreen] = max([IstatsGreen.Area]); 
    
    XcentroidGreen = [XcentroidGreen IstatsGreen(maxIndexGreen).Centroid(1)];
    YcentroidGreen = [YcentroidGreen IstatsGreen(maxIndexGreen).Centroid(2)];
    end 
     
 end
 
  imshow(rgb);
  hold on;
  scatter(Xcentroid, Ycentroid);
  scatter(XcentroidGreen, YcentroidGreen);
  