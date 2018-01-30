

//
//  User.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/30/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(ID, forKey: "ID")
        aCoder.encode(user_login, forKey: "user_login")
        aCoder.encode(user_pass, forKey: "user_pass")
        aCoder.encode(user_nicename, forKey: "user_nicename")
        aCoder.encode(user_email, forKey: "user_email")
        aCoder.encode(user_url, forKey: "user_url")
        aCoder.encode(user_registered, forKey: "user_registered")
        aCoder.encode(user_activation_key, forKey: "user_activation_key")
        aCoder.encode(user_status, forKey: "user_status")
        aCoder.encode(display_name, forKey: "display_name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        ID = aDecoder.decodeObject(forKey: "ID") as! Int?
        user_login = aDecoder.decodeObject(forKey: "user_login") as! String?
        user_pass = aDecoder.decodeObject(forKey: "user_pass") as! String?
        user_nicename = aDecoder.decodeObject(forKey: "user_nicename") as! String?
        user_email = aDecoder.decodeObject(forKey: "user_email") as! String?
        user_url = aDecoder.decodeObject(forKey: "user_url") as! String?
        user_registered = aDecoder.decodeObject(forKey: "user_registered") as! String?
        user_activation_key = aDecoder.decodeObject(forKey: "user_activation_key") as! String?
        user_status = aDecoder.decodeObject(forKey: "user_status") as! String?
        display_name = aDecoder.decodeObject(forKey: "display_name") as! String?
    }
    
    
    let ID: Int?
    let user_login: String?
    let user_pass: String?
    let user_nicename: String?
    let user_email: String?
    let user_url: String?
    let user_registered: String?
    let user_activation_key: String?
    let user_status: String?
    let display_name: String?
    
    required init(json: SwiftyJSON.JSON) {
        
        self.ID                     = json["ID"].intValue
        self.user_login             = json["user_login"].stringValue
        self.user_pass              = json["user_pass"].stringValue
        self.user_nicename          = json["user_nicename"].stringValue
        self.user_email             = json["user_email"].stringValue
        self.user_url               = json["user_url"].stringValue
        self.user_registered        = json["user_registered"].stringValue
        self.user_activation_key    = json["user_activation_key"].stringValue
        self.user_status            = json["user_status"].stringValue
        self.display_name           = json["display_name"].stringValue
        
    }
    
    
    class func detail(jsonString: SwiftyJSON.JSON) -> User {
        return User(json: jsonString)
    }
    
}
