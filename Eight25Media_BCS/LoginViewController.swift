
//
//  LoginViewController.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/28/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        if validateAll() {
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
            SVProgressHUD.show()
            WebServiceAPI.login(username: emailIDTextField.text!, password: passwordTextField.text!, success: { (user) in
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: SegueIdentifier.showDashboardVC, sender: nil)
            }, failure: { (error) in
                SVProgressHUD.dismiss()
                Helper.showAlert(APP_NAME, message: "Something went wrong, please try again later.", buttonTitles: "OK", viewController: self, completion: { (buttonIndex) in
                })
            })
            
        }
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(forSegue: segue) {
        case .showDashboardVC:
            let _ = segue.destination as! TabViewController
            
        }
    }
    
}

// MARK: SegueHandlerType
extension LoginViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case showDashboardVC
    }
}


extension LoginViewController {
    
    func validateEmailID() -> Bool {
        if emailIDTextField.text!.isEmpty || emailIDTextField.text! == "" {
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: APP_NAME, message: "EmailID cannot be empty", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alert = UIAlertView(title: APP_NAME, message: "EmailID cannot be empty", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            return false
        }
        return true
    }
    
    func validatePassword() -> Bool {
        if passwordTextField.text!.isEmpty || passwordTextField.text! == "" {
            if #available(iOS 8.0, *) {
                let alertController = UIAlertController(title: APP_NAME, message: "Password cannot be empty", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alert = UIAlertView(title: APP_NAME, message: "Password cannot be empty", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            return false
        }
        return true
    }
    
    
    func validateAll() -> Bool {
        if validateEmailID() && validatePassword() {
            return true
        }
        return false
    }
    
    
    
}
