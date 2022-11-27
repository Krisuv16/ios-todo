//
//  MainScreenViewController.swift
//  IOS-TODO
//
//  Created by Krisuv Bohara on 2022-11-13.
//

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
            DispatchQueue.main.async {
                self.dataLists.reloadData()
            }
        }catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = Date()
        let cells = dataLists.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath) as! CustomTableViewCell
        
        let thisNote: Note!
        
        //adding custom switch
        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cells.accessoryView = switchView
        
        //setting up value
        thisNote = dataList[indexPath.row]
        cells.titleLabel.text = thisNote.name
        cells.descLabel.text = thisNote.notes
        cells.dateLabel.text = "Due: " + (thisNote.dueDate ?? "No Due Date")
        switchView.setOn(thisNote.isCompleted, animated: true)

        //for adding strikethrough if its completed
        if(thisNote.isCompleted){
            cells.titleLabel.attributedText = addStrikeThrough(string: cells.titleLabel.text!)
            cells.descLabel.attributedText = addStrikeThrough(string: cells.descLabel.text!)
        }else{         //for removing strikethrough if its not completed
            cells.titleLabel.attributedText = removeStrikeThough(string: cells.titleLabel.text!)
            cells.descLabel.attributedText = removeStrikeThough(string: cells.descLabel.text!)
        }
        
        //comparing the date with datetime now and if date has passed the date label will be red
        if thisNote.date?.compare(date) == .orderedAscending {
            cells.dateLabel.textColor = UIColor.red
        }else{
            cells.dateLabel.textColor = UIColor.black
        }
        
        return cells
    }
    
    
    @objc func switchChanged(_ sender : UISwitch!){
        let thisNote: Note!
        thisNote = dataList[sender.tag]
        thisNote.isCompleted = sender.isOn
        print(thisNote.isCompleted)
        
        do{
            //saving the updated data
            try self.context.save()
            let indexPath = IndexPath(item: sender.tag, section: 0)
            //reloading the row that was changed
            dataLists.reloadRows(at: [indexPath], with: .automatic)
        }catch{}
        
    }
    
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
        performSegue(withIdentifier: "detailViewController", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //passing data to another view and
        if(segue.identifier == "detailViewController"){
            let index = dataLists.indexPathForSelectedRow!
            let noteDetails = segue.destination as? DetailViewController
            let selectedNote: Note!
            selectedNote = dataList[index.row]
            noteDetails?.dataList = selectedNote
            dataLists.deselectRow(at: index, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //runs when the view appears
        fetchNotes()
    }
    
}
