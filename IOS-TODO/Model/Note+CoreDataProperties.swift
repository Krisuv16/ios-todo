/*
 File Name: MainViewController
 Author: Krisuv Bohara(301274636), Niraj Nepal(301211100)
 Date: 2022-11-13
 Description: Creates the main UI of the Todo app
 Version: 1.0
 */

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var notes: String?
    @NSManaged public var hasDueDate: Bool
    @NSManaged public var dueDate: String?
    @NSManaged public var date: Date?

}

extension Note : Identifiable {

}
