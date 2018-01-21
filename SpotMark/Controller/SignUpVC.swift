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
        
        usernameTxtField.delegate = self
        emailAddressTxtField.delegate = self
        passwordTxtField.delegate = self
        passwordConfirmTxtField.delegate = self
        
        usernameTxtField.becomeFirstResponder()

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
            let alertController = UIAlertController(title: "Error", message: "Please fill in all the required fields", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if passwordConfirmTxtField.text != passwordTxtField.text {
            let alertController = UIAlertController(title: "Error", message: "The confirmation password does not match", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        AuthService().registerUser(withEmail: emailAddressTxtField.text!, andPassword: passwordTxtField.text!, andUsername: usernameTxtField.text!) { (success, error) in
            
            if success {
                print("User registered successfully")
                self.view.endEditing(true)
                self.performSegue(withIdentifier: "showWalkthrough", sender: nil)
            } else {
                print(error)
            }
            
        }
        
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    

}

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? CustomTextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return false
    }
    
}
