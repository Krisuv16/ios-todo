//
//  DetailViewController.swift
//  IOS-TODO
//
//  Created by Krisuv Bohara on 2022-11-13.
//

import UIKit

class DetailViewController: UIViewController {
    var dataList : Note!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var hasDueDate: UISwitch!
    @IBOutlet weak var isCompleted: UISwitch!
    @IBOutlet weak var dueTime: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = dataList.name ?? ""
        descriptionLabel.text = dataList.notes
        hasDueDate.isOn = dataList.hasDueDate
        isCompleted.isOn = dataList.isCompleted
        dueTime.date = dataList.date ?? Date.now
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onUpdate(_ sender: UIButton) {
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "MMM d yyyy, h:mm a "
        
        dataList.name = titleLabel.text
        dataList.notes = descriptionLabel.text
        dataList.hasDueDate = hasDueDate.isOn
        dataList.isCompleted = isCompleted.isOn
//        dataList.date = dueTime.date
        
        if(!hasDueDate.isOn){
            dataList.dueDate = nil
            dataList.date = nil
        }else{
            dataList.dueDate = formatter3.string(from: dueTime.date)
            dataList.date = dueTime.date
        }
        
        do{
            try self.context.save()

            _ = navigationController?.popToRootViewController(animated: true)
        
        }catch{}
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        self.context.delete(dataList)
        do{
            try self.context.save()
            _ = navigationController?.popToRootViewController(animated: true)
            
        }catch{}
    }
}
