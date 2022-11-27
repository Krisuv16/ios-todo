//
//  Note+CoreDataProperties.swift
//  IOS-TODO
//
//  Created by Krisuv Bohara on 2022-11-26.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var notes: String?
    @NSManaged public var hasDueDate: Bool
    @NSManaged public var dueDate: String?

}

extension Note : Identifiable {

}
