//
//  SignUpVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 20/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var usernameTxtField: CustomTextField!
    @IBOutlet weak var emailAddressTxtField: CustomTextField!
    @IBOutlet weak var passwordTxtField: CustomTextField!
    @IBOutlet weak var passwordConfirmTxtField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpWithFacebookBtnTapped(_ sender: Any) {
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
    }
    
    

}
