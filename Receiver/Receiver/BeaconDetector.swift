//
//  BeaconDetector.swift
//  Receiver
//
//  Created by Enkhjargal Gansukh on 02/11/2017.
//  Copyright © 2017 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import CoreLocation

class BeaconDetector: NSObject, CLLocationManagerDelegate {
    var detector: BeaconDetected!
    var locationManager: CLLocationManager!
    var isLocationAuthenticated = false
    let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "IDENTIFIER")
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            self.detector.lockDetected()
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons {
            if beacon.proximity == .near {
                // Detecting near Beacon
                print("Unlock the door")
                // Unlock the door
                detector.lockDetected()
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
}

protocol BeaconDetected {
    func lockDetected()
}
