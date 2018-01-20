//
//  DataService.swift
//  SpotMark
//
//  Created by Ludovic Saussinan on 20/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import Foundation
import Firebase
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_PLACES = DB_BASE.child("places")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_PLACES: DatabaseReference {
        return _REF_PLACES
    }
    
    func createDbUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
