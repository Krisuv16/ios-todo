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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onUpdate(_ sender: UIButton) {
        dataList.name = titleLabel.text
        dataList.notes = descriptionLabel.text
        dataList.hasDueDate = hasDueDate.isOn
        dataList.isCompleted = isCompleted.isOn
        
        do{
            try self.context.save()
            
        }catch{}
    }
    
    @IBAction func onDelete(_ sender: UIButton) {
        self.context.delete(dataList)
        do{
            try self.context.save()
            
        }catch{}
    }
}
