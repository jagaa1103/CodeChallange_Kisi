//
//  ViewController.swift
//  Receiver
//
//  Created by Enkhjargal Gansukh on 01/11/2017.
//  Copyright © 2017 Enkhjargal Gansukh. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class LockPageController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    var isLocationAuthenticated = false
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "IDENTIFIER")
    var unlockAnimationField: AnimationDrawer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      Unlock Animation initialize
        unlockAnimationField = AnimationDrawer(frame: CGRect(x: 0, y: view.frame.width/4, width: view.frame.width , height: view.frame.width))
        view.addSubview(unlockAnimationField)
//      Location Manager initialize
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        unlockDoor()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            if beacon.proximity == .near {
//                Detecting near Beacon
                print("Unlock the door")
//                Unlock the door
                self.unlockDoor()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            isLocationAuthenticated = true
            locationManager.startRangingBeacons(in: beaconRegion)
            locationManager.startUpdatingLocation()
            break
        default:
            isLocationAuthenticated = false
        }
    }
    
    
    var isLocked = true
    func unlockDoor(){
        let headers: HTTPHeaders = [
            "Authorization": "KISI-LINK 75388d1d1ff0dff6b7b04a7d5162cc6c",
            "Accept": "application/json"
        ]
        Alamofire.request("https://api.getkisi.com/locks/5873/access", method: .post, headers: headers).responseJSON { response in
            if let message = response.result.value as? [String: String]{
                if message["message"] == "Unlocked!" {
                    print("Yes!! Door unlocked")
//                  Door unlocked
                    self.unlockAnimationField.unlock()
                    self.isLocked = false
                }
            }
        }
    }
    
    @IBAction func lockDoorClicked(_ sender: Any) {
        if !isLocked {
            unlockAnimationField.lock()
            isLocked = true
        }
    }
}

