
//
//  DatePickerViewController.swift
//  Eight25Media_BCS
//
//  Created by Eight25media on 1/28/18.
//  Copyright © 2018 Eight25media. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate: class {
    func selectedDate(controller: DatePickerViewController, selectedDateString: String)
}

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: DatePickerViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        let date = self.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let dateStr = dateFormatter.string(from: date)
        print(dateStr)
        self.delegate?.selectedDate(controller: self, selectedDateString: dateStr)
        dismiss(animated: true, completion: nil)
    }

}
