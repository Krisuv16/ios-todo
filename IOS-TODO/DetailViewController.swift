/*
 File Name: MainViewController
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100)
 Date: 2022-11-13
 Description: Creates the main UI of the Todo app
 Version: 1.0
 */

import UIKit

class DetailViewController: UIViewController {
    var dataList : Note!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var hasDueDate: UISwitch!
    @IBOutlet weak var isCompleted: UISwitch!
    @IBOutlet weak var dueTime: UIDatePicker!
    
    
    @IBOutlet weak var titleLandScape: UITextField!
    @IBOutlet weak var descriptionLandScape: UITextField!
    @IBOutlet weak var hasDueDateLandscape: UISwitch!
    @IBOutlet weak var isCompletedLandscape: UISwitch!
    @IBOutlet weak var dueTimeLandscape: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = dataList.name ?? ""
        descriptionLabel.text = dataList.notes
        hasDueDate.isOn = dataList.hasDueDate
        isCompleted.isOn = dataList.isCompleted
        dueTime.date = dataList.date ?? Date.now
        
        titleLandScape.text = dataList.name ?? ""
        descriptionLandScape.text = dataList.notes
        hasDueDateLandscape.isOn = dataList.hasDueDate
        isCompletedLandscape.isOn = dataList.isCompleted
        dueTimeLandscape.date = dataList.date ?? Date.now

    }
    
    @IBAction func onUpdate(_ sender: UIButton) {
        //using alert Dialog
        let alert = UIAlertController(title: "Action Required", message: "Do you want to Update the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {action in
            
            //formating date
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "MMM d yyyy, h:mm a "
            
            self.dataList.name = self.titleLabel.text
            self.dataList.notes = self.descriptionLabel.text
            self.dataList.hasDueDate = self.hasDueDate.isOn
            self.dataList.isCompleted = self.isCompleted.isOn
            //        dataList.date = dueTime.date
            
            if(!self.hasDueDate.isOn){
                self.dataList.dueDate = nil
                self.dataList.date = nil
            }else{
                self.dataList.dueDate = formatter3.string(from: self.dueTime.date)
                self.dataList.date = self.dueTime.date
            }
            
            self.updateData()
        }))
        
        //presenting dialog
        present(alert, animated: true)
    }
    
    
    @IBAction func onUpdateLandScape(_ sender: UIButton) {
        //using alert Dialog

        let alert = UIAlertController(title: "Action Required", message: "Do you want to Update the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {action in
            //formating date
            let formatter3 = DateFormatter()
            formatter3.dateFormat = "MMM d yyyy, h:mm a "
            
            self.dataList.name = self.titleLandScape.text
            self.dataList.notes = self.descriptionLandScape.text
            self.dataList.hasDueDate = self.hasDueDateLandscape.isOn
            self.dataList.isCompleted = self.isCompletedLandscape.isOn
            //        dataList.date = dueTime.date
            
            if(!self.hasDueDateLandscape.isOn){
                self.dataList.dueDate = nil
                self.dataList.date = nil
            }else{
                self.dataList.dueDate = formatter3.string(from: self.dueTime.date)
                self.dataList.date = self.dueTimeLandscape.date
            }
            self.updateData()
            
        }))
        //presenting dialog

        present(alert, animated: true)
        
    }
    
    @IBAction func onDeleteLandScape(_ sender: UIButton) {
        let alert = UIAlertController(title: "Action Required", message: "Do you want to Delete the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            self.deleteData()
        }))
        present(alert, animated: true)
        
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        let alert = UIAlertController(title: "Action Required", message: "Do you want to Delete the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            self.deleteData()
        }))
        present(alert, animated: true)
    }
    
    //function for Deleting data
    func deleteData(){
        self.context.delete(dataList)
        do{
            try self.context.save()
            _ = navigationController?.popToRootViewController(animated: true)
            
        }catch{
            print("Error")
        }
    }
    
    //function for Updating data
    func updateData(){
        do{
            try self.context.save()
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        }catch{}
    }
    
    
    //cancel for LandScape Mode
    @IBAction func cancelLandScape(_ sender: UIButton) {
        cancelAction()
    }
    //cancel for potrait mod
    @IBAction func cancel(_ sender: UIButton) {
        cancelAction()
    }

    //FUnction Handling Cancel buttons
    func cancelAction(){
        let alert = UIAlertController(title: "Action Required", message: "Do you want to Discard Changes?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {action in
            _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
}
