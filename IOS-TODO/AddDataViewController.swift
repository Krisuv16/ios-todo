//
//  AddDataViewController.swift
//  IOS-TODO
//
//  Created by Krisuv Bohara on 2022-11-13.
//

import UIKit
import CoreData

class AddDataViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var uiSwitch: UISwitch!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var uiSwitchLandscape: UISwitch!
    @IBOutlet weak var datePickerLandscape: UIDatePicker!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add New Todo's"
        datePicker.isHidden = true
        datePickerLandscape.isHidden = true
        uiSwitch.isOn = false
        uiSwitchLandscape.isOn = false
        
    }
    
    @IBAction func dueDateSwitch(_ sender: UISwitch) {
        if(sender.isOn){
            datePicker.isHidden = false
            uiSwitch.isOn = true
        }else{
            datePicker.isHidden = true
            uiSwitch.isOn = false
        }
    }
    
    @IBAction func dueDateSwitchLandscape(_ sender: UISwitch) {
        if(sender.isOn){
            datePickerLandscape.isHidden = false
            uiSwitchLandscape.isOn = true
        }else{
            datePickerLandscape.isHidden = true
            uiSwitchLandscape.isOn = false
        }
    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "MMM d yyyy, h:mm a "
        print(formatter3.string(from: datePicker.date))
        
        
        
        let newNotes = Note(context: self.context)
        newNotes.id = Int32(truncating: 0 as NSNumber)
        newNotes.name = titleTextField.text
        newNotes.notes = descriptionTextField.text
        newNotes.dueDate = formatter3.string(from: datePicker.date)
        newNotes.isCompleted = completedSwitch.isOn
        newNotes.hasDueDate = uiSwitch.isOn

        do
        {
            try self.context.save()
            let _ =    try self.context.fetch(Note.fetchRequest())
        }
        catch {
            print("Error")
        }
        
        
    }
    
    
}
