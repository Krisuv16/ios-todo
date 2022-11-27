//
//  TodoModel.swift
//  IOS-TODO
//
//  Created by Krisuv Bohara on 2022-11-26.
//

import CoreData

@objc(Note)
class Note : NSManagedObject
{
    @NSManaged var id : NSNumber!
    @NSManaged var name : String!
    @NSManaged var notes : String!
    @NSManaged var isCompleted : Bool!
    @NSManaged var hasDueDate : Bool!
    @NSManaged var dueDate : String!
    
}
    
