/*
 File Name: MainViewController
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100)
 Date: 2022-11-13
 Description: Creates the main UI of the Todo app
 Version: 1.1
 */

import UIKit
import CoreData


class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var dataLists: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataList = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataLists.dataSource = self
        dataLists.delegate = self
        dataLists.separatorInset = dataLists.layoutMargins
        title = "TODO"
        fetchNotes()
    }
    
    func fetchNotes(){
        //Fetching data from CoreData and isplaying in the Table View
        do{
            self.dataList =  try context.fetch(Note.fetchRequest())
//            DispatchQueue.main.async {
                self.dataLists.reloadData()
//            }
        }catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
//
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let editAction = UIContextualAction(style: .destructive, title: "Edit") {
            (action, sourceView, completionHandler) in
            let thisNote: Note!
            thisNote = self.dataList[indexPath.row]
            self.performSegue(withIdentifier: "detailViewController", sender: thisNote)
        }
        
        
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (action, view, bool) in
            let thisNote: Note!
            thisNote = self.dataList[indexPath.row]
            thisNote.isCompleted = !thisNote.isCompleted
            do{
                //saving the updated data
                try self.context.save()
                let indexPath = IndexPath(item: indexPath.row, section: 0)
//                //reloading the row that was changed
                self.dataLists.reloadRows(at: [indexPath], with: .automatic)

            }catch{}
        }
        doneAction.backgroundColor = UIColor.green
        editAction.backgroundColor = UIColor.blue
        
        
        
        return UISwipeActionsConfiguration(actions: [doneAction,editAction])
    }
    
    
    //swiping right to left to delete the items in the table
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(editingStyle)
        if editingStyle == .delete {
            let thisNote: Note!
            thisNote = self.dataList[indexPath.row]
            self.context.delete(thisNote)
            
            do{
                try self.context.save()
            }
            catch{
                print("Error")
            }
            
            self.dataList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        
        
    }
    
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let filterAction = UIContextualAction(style: .normal, title: "Done") { (action, view, bool) in
//            let thisNote: Note!
//            thisNote = self.dataList[indexPath.row]
//            thisNote.isCompleted = !thisNote.isCompleted
//            do{
//                //saving the updated data
//                try self.context.save()
//                let indexPath = IndexPath(item: indexPath.row, section: 0)
////                //reloading the row that was changed
//                self.dataLists.reloadRows(at: [indexPath], with: .automatic)
//
//            }catch{}
//        }
//        filterAction.backgroundColor = UIColor.green
//        return UISwipeActionsConfiguration(actions: [filterAction])
//    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = Date()
        let cells = dataLists.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath) as! CustomTableViewCell
        
        let thisNote: Note!
        
//        cells.editBtn.tag = indexPath.row
//        cells.editBtn.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)

        //adding custom switch
//        let switchView = UISwitch(frame: .zero)
//        switchView.tag = indexPath.row // for detect which row switch Changed
//        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
//        cells.accessoryView = switchView
        
        //setting up value
        thisNote = dataList[indexPath.row]
        cells.titleLabel.text = thisNote.name
        cells.descLabel.text = thisNote.notes
        cells.dateLabel.text = "Due: " + (thisNote.dueDate ?? "No Due Date")
//        switchView.setOn(thisNote.isCompleted, animated: true)
        //for adding strikethrough if its completed
        
        if(thisNote.isCompleted){
            
            cells.titleLabel.attributedText = addStrikeThrough(string: cells.titleLabel.text!)
            cells.descLabel.attributedText = addStrikeThrough(string: cells.descLabel.text!)
            
        }else{         //for removing strikethrough if its not completed
            if(thisNote.name == nil){}
            else{
                cells.titleLabel.attributedText = removeStrikeThough(string: cells.titleLabel.text!)
                cells.descLabel.attributedText = removeStrikeThough(string: cells.descLabel.text!)}
            
        }
        
        //comparing the date with datetime now and if date has passed the date label will be red
        if thisNote.date?.compare(date) == .orderedAscending {
            cells.dateLabel.textColor = UIColor.red
        }else{
            cells.dateLabel.textColor = UIColor.black
        }
        
        return cells
    }
    
    
    @objc func subscribeTapped(_ sender: UIButton){
//        performSegue(withIdentifier: "detailViewController", sender: nil)

//               let index = dataLists.indexPathForSelectedRow!
//        let index = sender.tag
//        let noteDetails = DetailViewController()
//        let selectedNote: Note!
//        selectedNote = dataList[index]
//        noteDetails.dataList = selectedNote
////        dataLists.deselectRow(at: index, animated: true)
//        self.performSegue(withIdentifier: "editBtnSegue", sender: self)
    }
    
    
//    @objc func switchChanged(_ sender : UISwitch!){
//        let thisNote: Note!
//        thisNote = dataList[sender.tag]
//        thisNote.isCompleted = sender.isOn
//        do{
//            //saving the updated data
//            try self.context.save()
//            let indexPath = IndexPath(item: sender.tag, section: 0)
//            //reloading the row that was changed
//            dataLists.reloadRows(at: [indexPath], with: .automatic)
//
//        }catch{}
//
//    }
    
    
    
    func addStrikeThrough (string : String) -> NSMutableAttributedString{
        //adding a strikethrough
        let stringAttribute: NSMutableAttributedString =  NSMutableAttributedString(string: string)
        stringAttribute.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, stringAttribute.length))
        return stringAttribute
    }
    
    func removeStrikeThough(string : String) -> NSMutableAttributedString{
        //removing a strikethrough
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: string)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigation to another view
        let thisNote: Note!
        thisNote = self.dataList[indexPath.row]
        performSegue(withIdentifier: "detailViewController", sender: thisNote)
        }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailViewController = segue.destination as? DetailViewController {
            if let data = sender as? Note {
                detailViewController.dataList = data
            }
        }
        
        //passing data to another view
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //runs when the view appears
        fetchNotes()
    }
    
}
