//
//  LoginVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 20/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxtField: CustomTextField!
    @IBOutlet weak var passTxtField: CustomTextField!
    @IBOutlet weak var loginBtn: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func logginBtnTapped(_ sender: Any) {
    }
    
    @IBAction func logginWithFacebookTapped(_ sender: Any) {
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
    }
    
    
}
