//
//  ProfilePage.swift
//  Receiver
//
//  Created by Enkhjargal Gansukh on 01/11/2017.
//  Copyright © 2017 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import UIKit

class ProfilePageController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width/2
        self.profilePhoto.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
    }
}
