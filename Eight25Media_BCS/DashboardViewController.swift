
//
//  DashboardViewController.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/28/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit
import SVProgressHUD
import DZNEmptyDataSet

class DashboardViewController: UIViewController {

    var allClaims = [Claim]()
    var pendingClaims = [Claim]()
    var approvedClaims = [Claim]()
    var cancelledClaims = [Claim]()
    
//    Status = 1 Pending
//    Status = 2 Project Approved / Head of Delivery pending / Accountat pending
//    Status = 3 Project Approved / Head of Delivery Approved Accountat pending
//    Status = 4 All Approved
//    Status = 0 cancelled
    
    var claimType = 123
    
    @IBOutlet weak var claimTable: UITableView!
    
    var showMesssage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let loggedinUser = UserSession.shared.currentUser else {
            return
        }
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.show()
        WebServiceAPI.getClaims(userID: loggedinUser.ID!, success: { (claims) in
            SVProgressHUD.dismiss()
            
            self.allClaims = claims
            self.pendingClaims = self.allClaims.filter { $0.status == 1 || $0.status == 2 || $0.status == 3 }
            self.approvedClaims = self.allClaims.filter { $0.status == 4 }
            self.cancelledClaims = self.allClaims.filter { $0.status == 0 }
            
            if self.pendingClaims.count == 0 {
                self.showMesssage = true
            } else {
                self.showMesssage = false
            }
            
            if self.approvedClaims.count == 0 {
                self.showMesssage = true
            } else {
                self.showMesssage = false
            }
            
            if self.cancelledClaims.count == 0 {
                self.showMesssage = true
            } else {
                self.showMesssage = false
            }
            
            self.claimTable.reloadData()
            
        }) { (statusCode) in
            SVProgressHUD.dismiss()
            Helper.showAlert(APP_NAME, message: "Something went wrong, please try again later.", buttonTitles: "OK", viewController: self, completion: { (buttonIndex) in
            })
        }
    }
    
    @IBAction func pendingApprovedAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.claimType = 123
            self.claimTable.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            self.claimType = 4
            self.claimTable.reloadData()
        } else if sender.selectedSegmentIndex == 2 {
            self.claimType = 0
            self.claimTable.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(forSegue: segue) {
        case .showNewClaimVC:
            let _ = segue.destination as! NewClaimViewController
        case .showClaimDetailsVC:
            let destinationVC = segue.destination as! ClaimDetailsViewController
            destinationVC.claim = sender as! Claim
        }
    }
    
    @IBAction func newClaim(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifier.showNewClaimVC, sender: nil)
    }
    
}

// MARK: SegueHandlerType
extension DashboardViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case showNewClaimVC
        case showClaimDetailsVC
    }
}


extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.claimType == 4 {
            return self.approvedClaims.count
        } else if self.claimType == 123 {
            return self.pendingClaims.count
        } else {
            return self.cancelledClaims.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID_DashboardTableViewCell", for: indexPath) as! DashboardTableViewCell
        
        var claim: Claim
        
        print("Type : \(self.claimType)")
        
        if self.claimType == 4 {
            claim = approvedClaims[indexPath.row]
        } else if self.claimType == 123 {
            claim = pendingClaims[indexPath.row]
        } else {
            claim = cancelledClaims[indexPath.row]
        }
        
        cell.projectName.text = claim.project
        cell.claimDate.text = claim.date
        return cell
    }
}

extension DashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var claim: Claim
        print("Type : \(self.claimType)")
        if self.claimType == 4 {
            claim = approvedClaims[indexPath.row]
        } else if self.claimType == 123 {
            claim = pendingClaims[indexPath.row]
        } else {
            claim = cancelledClaims[indexPath.row]
        }
        
        performSegue(withIdentifier: SegueIdentifier.showClaimDetailsVC, sender: claim)
        
    }
}


// MARK: - DZNEmptyDataSetSource
extension DashboardViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var title = ""
        if showMesssage == true {
            if claimType == 0 {
                title = "No cancelled claim requests"
            } else if claimType == 123 {
                title = "No pending claim requests"
            } else {
                title = "No approved claim requests"
            }
            
        }
        
        let attributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.darkGray,
            .font : UIFont.boldSystemFont(ofSize: 18)
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var description = ""
        if showMesssage == true {
//            description = "Please make a claim to see requests details"
            if claimType == 0 {
              description = "Once available cancelled claim requests will show up here."
            } else if claimType == 123 {
                description = "Once available pending claim requests will show up here."
            } else {
                description = "Once available approved claim requests will show up here."
            }
        }
        
        let paragraph: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        let attributes: [NSAttributedStringKey: Any] = [
            .foregroundColor : UIColor.lightGray,
            .font : UIFont.boldSystemFont(ofSize: 14),
            .paragraphStyle : paragraph
        ]
        return NSAttributedString(string: description, attributes: attributes)
    }
}
