#Change Log

##11/18/2016
- ImageUtils updated.
- MSERManager added.
- FeatureDetection removed from iOS application.
- ViewController NSTableView implemented.
- Other small changes.

##11/17/2016
- OpenCV MSER test (macOS) implemented.
- Project target changed from iOS 9 to iOS 8. MSER works correctly.
- Other small changes.
- OpenCV iOS pod removed. Framework outdated.
- OpenCV static framework added. Dependencies added.
- Some code changed based on framework updated. Specifically, MSER
detection no longer need bounding box and cap_ios.h directory changed.
- OpenCV test implementation began. ImageUtils class finished.
- Other small changes.

Note:
OpenCV macOS framework also need to be updated. The same process
applies. After full updated, test the result. Refer to MSER example
project for details. Good luck.

##11/15/2016
####Committer: Neil Nie
- `ObjectTracking` class can no longer draw points on the output frame. 
- `ObjectTracking Sample` `pointsPrev` and `pointsNext` are now public variables. 
- `ObjectTracking Sample` `extreme` class variable added. 
- `ObjectTracking Sample` calculate extreme method implemented. 
-  `SampleFacade` `getPointNext` and `getExtreme` method implemented. 
-  `VideoViewController` log points and extreme points.
-  Main.storyboard updated. 
-  Other small changes. 
-  `SampleObject` class deprecated. `ObjectTrack` and `FeatureDetection` are no longer subclass of former.   

Note:
In the future, we need to draw points based on the pointNext and extreme from ObjectTrackingSample. Also, we can track the location of the object relative to the frame. 