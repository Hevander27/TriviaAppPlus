//
//  MenuViewController.swift
//  Trivia
//
//  Created by libraries on 10/12/23.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var dropdownPicker1: UIPickerView!
    @IBOutlet weak var dropdownPicker2: UIPickerView!
    @IBOutlet weak var dropdownPicker3: UIPickerView!
    @IBOutlet weak var dropdownPicker4: UIPickerView!

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!

    let dropdownData1 = ["Option 1.1", "Option 1.2", "Option 1.3", "Option 1.4"]
    let dropdownData2 = ["Option 2.1", "Option 2.2", "Option 2.3", "Option 2.4"]
    let dropdownData3 = ["Option 3.1", "Option 3.2", "Option 3.3", "Option 3.4"]
    let dropdownData4 = ["Option 4.1", "Option 4.2", "Option 4.3", "Option 4.4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegates and data sources for the picker views
        dropdownPicker1.delegate = self
        dropdownPicker1.dataSource = self
        dropdownPicker2.delegate = self
        dropdownPicker2.dataSource = self
        dropdownPicker3.delegate = self
        dropdownPicker3.dataSource = self
        dropdownPicker4.delegate = self
        dropdownPicker4.dataSource = self

        // Set initial text for text fields
        textField1.text = dropdownData1[0]
        textField2.text = dropdownData2[0]
        textField3.text = dropdownData3[0]
        textField4.text = dropdownData4[0]
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dropdownPicker1 {
            return dropdownData1.count
        } else if pickerView == dropdownPicker2 {
            return dropdownData2.count
        } else if pickerView == dropdownPicker3 {
            return dropdownData3.count
        } else if pickerView == dropdownPicker4 {
            return dropdownData4.count
        }
        return 0
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == dropdownPicker1 {
            return dropdownData1[row]
        } else if pickerView == dropdownPicker2 {
            return dropdownData2[row]
        } else if pickerView == dropdownPicker3 {
            return dropdownData3[row]
        } else if pickerView == dropdownPicker4 {
            return dropdownData4[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue: String
        if pickerView == dropdownPicker1 {
            selectedValue = dropdownData1[row]
            textField1.text = selectedValue
        } else if pickerView == dropdownPicker2 {
            selectedValue = dropdownData2[row]
            textField2.text = selectedValue
        } else if pickerView == dropdownPicker3 {
            selectedValue = dropdownData3[row]
            textField3.text = selectedValue
        } else if pickerView == dropdownPicker4 {
            selectedValue = dropdownData4[row]
            textField4.text = selectedValue
        }
        // Handle the selected value
    }
}
