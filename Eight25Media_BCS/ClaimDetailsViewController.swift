
//
//  ClaimDetailsViewController.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/30/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit

class ClaimDetailsViewController: UIViewController {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectDescription: UILabel!
    @IBOutlet weak var claimDate: UILabel!
    @IBOutlet weak var claimType: UILabel!
    @IBOutlet weak var claimAmount: UILabel!
    @IBOutlet weak var others: UILabel!
    
    var claim: Claim!
    
    @IBOutlet weak var accountant: UILabel!
    @IBOutlet weak var headOfDelivery: UILabel!
    @IBOutlet weak var projectManager: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.projectName.text = "Project : \(claim.project)"
        if let desc = claim.claimdescription {
            self.projectDescription.text = "Description : \(desc)"
        } else {
            self.projectDescription.text = "Description :"
        }
        
        self.claimDate.text = "Date : \(claim.date)"
        self.claimType.text = "Type : \(claim.type)"
        self.claimAmount.text = "Amount : LKR \(claim.amount)"
        if let others = claim.others {
            self.others.text = "Others : \(others)"
        } else {
            self.others.text = "Others :"
        }
        
        switch claim.status {
        case 1:
            self.projectManager.text = "Project Manager - Pending"
            self.headOfDelivery.text = "Head of delivery - Pending"
            self.accountant.text = "Accountant - Pending"
        case 2:
            self.projectManager.text = "Project Manager - Approved"
            self.headOfDelivery.text = "Head of delivery - Pending"
            self.accountant.text = "Accountant - Pending"
        case 3:
            self.projectManager.text = "Project Manager - Approved"
            self.headOfDelivery.text = "Head of delivery - Approved"
            self.accountant.text = "Accountant - Pending"
        case 4:
            self.projectManager.text = "Project Manager - Approved"
            self.headOfDelivery.text = "Head of delivery - Approved"
            self.accountant.text = "Accountant - Approved"
        default:
            self.projectManager.text = ""
            self.headOfDelivery.text = ""
            self.accountant.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func doneButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
    }
}
