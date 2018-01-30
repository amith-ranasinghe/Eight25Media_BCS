
//
//  WebServiceAPI.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/30/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebServiceAPI: NSObject {
    
    enum WSEndPoint:String {
        case login = "wp-json/claims/v1/user/"
        case getClaims = "wp-json/claims/v1/author/"
        func urlString()->String {
            return "\(BASE_API)\(self.rawValue)"
        }
    }
    
    class func login(username: String, password: String,
                     success:@escaping(_ user: User)->(),
                     failure:@escaping(_ failedMsg:Int)->()) {
        
        let url = WSEndPoint.login.urlString()
        
        // Add URL parameters
        let urlParams = [ "email": username, "password": password, ]
        
        // Fetch Request
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: .get, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                
                if statusCode == 200 {
                    
                    switch response.result {
                    case .success:
                        
                        if let value = response.result.value {
                            let json = JSON(value)
                            let data: User = User.detail(jsonString: json)
                            success(data)
                            print(json)
                            
                            let loggedUser = NSKeyedArchiver.archivedData(withRootObject: data)
                            UserDefaults.standard.set(loggedUser, forKey: "LOGGED_IN_USER")
                            UserDefaults.standard.synchronize()
                            
                        }
                        
                    case .failure(let error):
                        failure(statusCode)
                        print(error)
                    }
                } else {
                    failure(statusCode)
                }
                
        }
    }
    
    
    class func getClaims(userID: Int,
                   success:@escaping(_ user: [Claim])->(),
                   failure:@escaping(_ failedMsg:Int)->()) {
        
        let url = WSEndPoint.getClaims.urlString()
        
        // Add URL parameters
        let urlParams = [ "id": userID, ]
        
        // Fetch Request
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url, method: .get, parameters: urlParams)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                
                if statusCode == 200 {
                    
                    switch response.result {
                    case .success:
                        
                        if let value = response.result.value {
                            let json = JSON(value)
                            let data: [Claim] = Claim.array(jsonString: json)
                            success(data)
                            print(json) 
                        }
                        
                    case .failure(let error):
                        failure(statusCode)
                        print(error)
                    }
                } else {
                    failure(statusCode)
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
