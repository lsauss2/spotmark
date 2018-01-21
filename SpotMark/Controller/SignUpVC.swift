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
        
        if usernameTxtField.text == "" || emailAddressTxtField.text == "" || passwordTxtField.text == "" || passwordConfirmTxtField.text == "" {
            print("Field empty")
            return
        }
        
        if passwordConfirmTxtField.text != passwordTxtField.text {
            print("Password does not match")
            return
        }
        
        AuthService().registerUser(withEmail: emailAddressTxtField.text!, andPassword: passwordTxtField.text!, andUsername: usernameTxtField.text!) { (success, error) in
            
            if success {
                print("User registered successfully")
            } else {
                print(error)
            }
            
        }
        
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
