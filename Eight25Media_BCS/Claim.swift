
//
//  Claim.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/30/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit
import SwiftyJSON

class Claim: NSObject {

    let id: Int
    let uid: Int
    let date: String
    let amount: String
    let claimdescription: String?
    let type: String
    let project: String
    let others: String?
    let status: Int
    
    required init(json: SwiftyJSON.JSON) {
        
        self.id = json["id"].intValue
        self.uid = json["uid"].intValue
        self.date = json["date"].stringValue
        self.amount = json["amount"].stringValue
        self.claimdescription = json["description"].stringValue
        self.type = json["type"].stringValue
        self.project = json["project"].stringValue
        self.others = json["others"].stringValue
        self.status = json["status"].intValue
    }
    
    class func array(jsonString: SwiftyJSON.JSON) -> [Claim] {
        
        var claims = [Claim]()
        
        for (_, subJson) in jsonString {
            let obj:Claim = Claim(json: subJson)
            claims.append(obj)
        }
        
        return claims
    }
    
    
}
