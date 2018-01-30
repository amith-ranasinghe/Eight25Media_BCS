
//
//  NewClaimViewController.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/28/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit

class NewClaimViewController: UIViewController {

    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var projectManagerTextField: UITextField!
    @IBOutlet weak var reasonForLateWork: UITextView!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func foodSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func travelSwitch(_ sender: UISwitch) {
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifier.showDatePickerVC, sender: nil)
    }
    
    @IBAction func projectAction(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifier.showProjectsVC, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(forSegue: segue) {
        case .showDatePickerVC:
            let destinationVC = segue.destination as! DatePickerViewController
            destinationVC.delegate = self
            
        case .showProjectsVC:
            let destinationVC = segue.destination as! ProjectsViewController
            destinationVC.delegate = self
        }
    }
    
}

// MARK: SegueHandlerType
extension NewClaimViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case showDatePickerVC
        case showProjectsVC
    }
}


extension NewClaimViewController: DatePickerViewControllerDelegate {
    func selectedDate(controller: DatePickerViewController, selectedDateString: String) {
        print("selectedDateString : \(selectedDateString)")
        self.dateTextField.text = selectedDateString
    }
}

extension NewClaimViewController: ProjectsViewControllerDelegate {
    func selectedProject(controller: ProjectsViewController, selectedProjectName: String) {
        print(selectedProjectName)
    }
}

