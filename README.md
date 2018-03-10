# Object Tracking
Object tracking application using Open Computer Vision Framework. 

Please read and agree to this 
[license](https://creativecommons.org/licenses/by-nc-nd/4.0/legalcode)


## Introducion
The goal for this application is to detect & track a portion of an image based on the user selection. The project explores different algorithms and find the most optmized solution. Currently, there are companies and organization that have acheived this goal with different platforms, such as DJI Phantom 4 Drone with Visual Tracking

I am also writing a research paper on this project. If you are interested in that, please let me know. 

## Screen Shot

Learn a template            |  Learning result
:-------------------------:|:-------------------------:
![ScreenShot](https://c1.staticflickr.com/3/2484/32923106685_9658c3882d_b.jpg) |  ![ScreenShot](https://c1.staticflickr.com/3/2227/32108280423_c0664ae1b8_b.jpg)

Real time detection            |  Settings*
:-------------------------:|:-------------------------:
![](https://c1.staticflickr.com/1/620/32079993634_357917688e_b.jpg)| ![ScreenShot](https://c1.staticflickr.com/1/744/32079993594_c8d73e40b7_b.jpg)

*Yet to be finished. Contributions are welcomed

## Algorithms

MSER help us to identify and track objects (regions). With MSER, we can teach the computer different images, pattern. I newly created a macOS application for MSER testing. Current, MSER is our biggest focus. We have had success in detecting regions as well as tracking regions. In the iOS application, you can programmatically set the template image to track (ex. cocola logo) then test it with realworld images. (Upon your request, I will be able to provide more information)

This project has a couple of algorithms, LKT algorithm is great at analyzing the content of a frame. It's fast and easy to implement. This algorithm is specifically used in the `ObjectTracking` class. That class is wrapped with `ObjectTrackingSample` class, which is more user friendly and actually gives you some useful data. `SampleFacade` is a objective-c++ class that directly talk to the ViewController. In there, you can find familiar classes such as `NSMutableArray` (instead of `std::vector`) <br>

After some development and testing, the object tracking class is more reliable and purposeful than the other algorithms. However, improvements are need, please don't hesitate to fork this repo and make pull requests. 

We also tried to use feature detections algorithms (in OpenCV): [ORB](http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_feature2d/py_orb/py_orb.html), [AKAZE](https://www.doc.ic.ac.uk/~ajd/Publications/alcantarilla_etal_eccv2012.pdf), [FAST](http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_feature2d/py_fast/py_fast.html). These algorithms are no longer supported. Our goal was to combine parts of different algorithms and train the computer to identify and track objects in realtime. (For more information, please visit the links above or the OpenCV documentations.)

## Usages
Download / Clone the project. **This project no longer support cocoapods**. When the project is download, please make sure to change the `Framework Search Path`. <br>In another word, you have to download **OpenCV compiled frameworks** and change the **framework search path** or **copy it into the project**. I apologize for the inconvience. Cocoapods OpenCV is outdated and shouldn't be used.

Important changes are recorded on Github or please refer to the change log. 

## About me:
Developed and maintained by Neil Nie. If you are intereste, please check out my other [repositories](github.com/NeilNie). 

[My blog](neilnie.com) | [Email](contact@neilnie.com) | [LinkedIn](https://www.linkedin.com/in/yongyang-neil-nie-896204118/)

Thanks to:

- Anton Belodedenko anton.belodedenko@gmail.com
- Emmanuel d'Angelo http://www.computersdontsee.net
- Daniel J. Pinter datazombies@gmail.com
- BloodAxe http://computer-vision-talks.com/
