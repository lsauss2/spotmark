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
    
    func registerUser(withEmail email:String, andPassword password:String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        
    }
    
    func loginUser(withEmail email:String, andPassword password:String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        
    }
}
