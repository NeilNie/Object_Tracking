#Change Log
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