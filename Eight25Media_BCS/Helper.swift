//
//  Helper.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/30/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    //Ref: http://stackoverflow.com/a/25471164
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        //"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$" // from synapsys
        //"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailRegEx = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func showAlert(_ title: String,
                         message: String ,
                         buttonTitles: String ..., viewController: UIViewController,
                         completion: @escaping (Int) -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (buttonIndex, buttonTitle) in buttonTitles.enumerated() {
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
                completion(buttonIndex)
            })
            alertController.addAction(action)
        }
        viewController.present(alertController, animated: true, completion: nil)
    }
}
