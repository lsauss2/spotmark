//
//  ProfileVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    
    @IBOutlet weak var userThumb: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var placesCountLbl: UILabel!
    @IBOutlet weak var followingCountLbl: UILabel!
    @IBOutlet weak var followerCountLbl: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editProfileBtnTapped(_ sender: Any) {
    }


}
