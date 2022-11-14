//
//  MainScreenViewController.swift
//  IOS-TODO
//
//  Created by Krisuv Bohara on 2022-11-13.
//

import UIKit

class MainScreenViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var dataLists: UITableView!
        struct Mods{
        let title : String
        let desc : String
        let date : String
        let status : Bool
    }
    
    let data : [Mods] = [
        Mods(
            title: "Title 1",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "June 20, 2022",
            status: true),
        Mods(
            title: "Title 2",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "August 20, 2022",
            status: false),
        Mods(
            title: "Title 3",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "November 20, 2022",
            status: true),
        Mods(
            title: "Title 4",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "December 20, 2022",
            status: false),
        Mods(
            title: "Title 5",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "Completed",
            status: true),
        
        Mods(
            title: "Title 6",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "OverDue",
            status: true),
        Mods(
            title: "Title 7",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "OverDue",
            status: false),
        Mods(
            title: "Title 8",
            desc: "In a storyboard-based application, you will often want to do a little preparation before navigation",
            date: "OverDue",
            status: true),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataLists.dataSource = self
        title = "TODO"
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mods = data[indexPath.row]
        let cells = dataLists.dequeueReusableCell(withIdentifier: "tableCells", for: indexPath) as! CustomTableViewCell
        cells.titleLabel.text = mods.title
        cells.descLabel.text = mods.desc
        cells.dateLabel.text = mods.date
//        cells.switchBtn.text =  mods.status
        return cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("xxxadasdadadasdadasdad")
        print(data[indexPath.row].title)
        print("xxxadasdadadasdadasdad")

        
        performSegue(withIdentifier: "detailViewController", sender: nil)
        }
}
