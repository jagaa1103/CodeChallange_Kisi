# CodeChallange_Kisi
# Receiver

It's simple iOS application works with iBeacon.

Using frameworks: 
* CoreLocation
* Alamofire

It's simple MVC app. Models, Views, Controllers...

Steps of app:
- Launch app and waiting 10secs
- First 5sec Blue SplashScreen Loading
- And 5 sec later you can see TabView. This view has 2 tabs (LockView & ProfileView)
- when the LockView openned so run 5 sec later BeaconDetector notify beacon detected event. 
    (Didn't set iBeacon Region identifier and other identifiers not yet.)
  Unlock animation is starting
- ProfileView is very simple static view.







