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
    @IBOutlet weak var isCompletedLandscape: UISwitch!
    @IBOutlet weak var titleLandscape: UITextField!
    @IBOutlet weak var descriptionLandscape: UITextField!
    
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
        
        let alert = UIAlertController(title: "Action Required", message: "Do you want to submit the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "MMM d yyyy, h:mm a "
                
            let newNotes = Note(context: self.context)
            newNotes.id = Int32(truncating: 0 as NSNumber)
            newNotes.name = self.titleTextField.text
            newNotes.notes = self.descriptionTextField.text
            newNotes.isCompleted = self.completedSwitch.isOn
            newNotes.hasDueDate = self.uiSwitch.isOn
            
            if(self.uiSwitch.isOn){
                newNotes.dueDate = formatter3.string(from: self.datePicker.date)
                newNotes.date = self.datePicker.date
            }
            self.saveData()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func onSubmitLandScape(_ sender: UIButton) {
        let alert = UIAlertController(title: "Action Required", message: "Do you want to submit the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
            
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "MMM d yyyy, h:mm a "
                
            let newNotes = Note(context: self.context)
            newNotes.id = Int32(truncating: 0 as NSNumber)
            newNotes.name = self.titleLandscape.text
            newNotes.notes = self.descriptionLandscape.text
            newNotes.isCompleted = self.isCompletedLandscape.isOn
            newNotes.hasDueDate = self.uiSwitchLandscape.isOn
            
            if(self.uiSwitchLandscape.isOn){
                newNotes.dueDate = formatter3.string(from: self.datePickerLandscape.date)
                newNotes.date = self.datePickerLandscape.date
            }
            self.saveData()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
        
    }
    
    //saving the data in the core data
    func saveData() {
        do
        {
            try self.context.save()
            let _ = try self.context.fetch(Note.fetchRequest())
        }
        catch {
            print("Error")
        }
    }
    
    //clearing fields in Potrailt
    @IBAction func onClear(_ sender: UIButton) {
        titleTextField.text = ""
        descriptionTextField.text = ""
        uiSwitch.isOn = false
        completedSwitch.isOn = false
        datePicker.isHidden = true
    }
    
    //clearing fields in LandScape
    @IBAction func onClearLandscape(_ sender: UIButton) {
        titleLandscape.text = ""
        descriptionLandscape.text = ""
        uiSwitchLandscape.isOn = false
        isCompletedLandscape.isOn = false
        datePickerLandscape.isHidden = true
    }
    
}
