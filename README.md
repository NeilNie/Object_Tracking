# Object_Tracking
Object tracking application using Open Computer Vision Framework. 

##Introducion
The goal for this application is to track a part of an image based on user selection. The project explores different algorithms and find the most optmized solution. Currently, there are companies and organization that have acheived this goal with different platforms, such as DJI Phantom 4 Drone with Visual Tracking (r)(c)

##Algorithms
This projects uses many algorithms, LKT algorithm is great at analyzing the content of a frame. It's fast and easy to implement. This algorithm is specifically used in the `ObjectTracking` class. That class is wrapped with `ObjectTrackingSample` class, which is more user friendly and actually gives you some useful data. `SampleFacade` is a objective-c++ class that directly talk to the ViewController. In there, you can find familiar classes such as `NSMutableArray` (instead of `std::vector`) <br>

After some development and testing, the object tracking class is more reliable and purposeful than the other algorithms. However, improvements are need, please don't hesitate to fork this repo and make pull requests. 

MSER help us to identify and track objects (regions). With MSER, we can teach the computer different images, pattern. <br>

We also use feature detections algorithms (in OpenCV): [ORB](http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_feature2d/py_orb/py_orb.html), [AKAZE](https://www.doc.ic.ac.uk/~ajd/Publications/alcantarilla_etal_eccv2012.pdf), [FAST](http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_feature2d/py_fast/py_fast.html). Eventually, our goal is to combine parts of different algorithms and train the computer to identify and track objects in realtime. (For more information, please visit the links above or the OpenCV documentations)

##Usages
Download/Clone the project. Open Object_Track workspace and you are good to go. If the pods are not installed, please run `pod install`. You can only run this project on an 64-bit iPhone, not simulators. We don't recommend running it on 32-bit devices. 

Important changes are recorded on Github or please refer to the change log. 

##Credit:
Developed and maintained by Neil Nie. If you are intereste, please check out my other repositories. 

Contact: appledeveloper.neil@gmail.com

Thanks to:

- Anton Belodedenko anton.belodedenko@gmail.com
- Emmanuel d'Angelo http://www.computersdontsee.net
- Daniel J. Pinter datazombies@gmail.com
- BloodAxe http://computer-vision-talks.com/
