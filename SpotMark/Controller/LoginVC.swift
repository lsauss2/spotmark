//
//  LoginVC.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 20/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxtField: CustomTextField!
    @IBOutlet weak var passTxtField: CustomTextField!
    @IBOutlet weak var loginBtn: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTxtField.delegate = self
        passTxtField.delegate = self
        
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser!.email!)
        } else {
            "No user found"
        }
    

        // Do any additional setup after loading the view.
    }


    @IBAction func logginBtnTapped(_ sender: Any) {
        
        if emailTxtField.text != "" && passTxtField.text != "" {
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, andPassword: passTxtField.text!, loginComplete: { (success, error) in
                
                if success {
                    print("User logged in")
                    self.performSegue(withIdentifier: "showHomeFromLogin", sender: nil)
                } else {
                    print(error)
                }
                
            })
        }
        
    }
    
    @IBAction func logginWithFacebookTapped(_ sender: Any) {
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "showSignUp", sender: nil)
    }
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "showForgotVC", sender: nil)
    }
    
    
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? CustomTextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
}
