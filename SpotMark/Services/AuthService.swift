//
//  AuthService.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 21/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email:String, andPassword password:String, andUsername username:String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provide": user.providerID, "email": user.email, "username": username]
            DataService.instance.createDbUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email:String, andPassword password:String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            guard let user = user else {
                loginComplete(false, error)
                return
            }
            
            loginComplete(true, nil)
            
        }
        
    }
}
