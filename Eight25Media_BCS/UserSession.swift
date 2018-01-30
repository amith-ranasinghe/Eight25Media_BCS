
//
//  UserSession.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/30/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit

class UserSession {
    
    static let shared:UserSession = UserSession()
    
    fileprivate var loggedInCustomer:User!
    
    func removeUserSession(){
        UserDefaults.standard.removeObject(forKey: "TOKEN")
        UserDefaults.standard.removeObject(forKey: "LOGGED_IN_USER")
        UserDefaults.standard.synchronize()
        loggedInCustomer = nil
    }
    
    var currentUser:User?{
        
        get{
            if loggedInCustomer == nil {
                
                if let userData = UserDefaults.standard.object(forKey: "LOGGED_IN_USER") as? NSData {
                    loggedInCustomer = NSKeyedUnarchiver.unarchiveObject(with: userData as Data) as? User
                }else{
                    return nil
                }
            }
            return loggedInCustomer
        }
        
        set {
            
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "LOGGED_IN_USER")
            }else{
                let userData = NSKeyedArchiver.archivedData(withRootObject: newValue!)
                UserDefaults.standard.set(userData, forKey: "LOGGED_IN_USER")
                UserDefaults.standard.synchronize()
            }
            
            loggedInCustomer = newValue
            
        }
    }
}
