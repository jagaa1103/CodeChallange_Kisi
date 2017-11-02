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

class LockPageController: UIViewController, BeaconDetected {
    
    var unlockAnimationField: AnimationDrawer!
    var beaconDetector = BeaconDetector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      Unlock Animation initialize
        unlockAnimationField = AnimationDrawer(frame: CGRect(x: 0, y: view.frame.width/4, width: view.frame.width , height: view.frame.width))
        view.addSubview(unlockAnimationField)
        beaconDetector.detector = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
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
    
    func lockDetected() {
        print("========= lockDetected ==========")
        self.unlockDoor()
    }
}

