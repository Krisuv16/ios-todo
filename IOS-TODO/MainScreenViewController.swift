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
        let cells = dataLists.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath) as! CustomTableViewCell
        
        let thisNote: Note!
        
        let switchView = UISwitch(frame: .zero)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cells.accessoryView = switchView
        
        thisNote = dataList[indexPath.row]
        cells.titleLabel.text = thisNote.name
        cells.descLabel.text = thisNote.notes
        cells.dateLabel.text = "Due: " + thisNote.dueDate!
        switchView.setOn(thisNote.isCompleted, animated: true)
        return cells
    }
    
    @objc func switchChanged(_ sender : UISwitch!){

          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailViewController", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        fetchNotes()
    }
    
}
