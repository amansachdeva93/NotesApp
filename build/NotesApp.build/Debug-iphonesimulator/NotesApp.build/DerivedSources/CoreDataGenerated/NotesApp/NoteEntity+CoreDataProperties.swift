//
//  NoteEntity+CoreDataProperties.swift
//  
//
//  Created by Amanpreet Singh on 29/05/23.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var status: Bool
    @NSManaged public var time: String?
    @NSManaged public var title: String?

}

extension NoteEntity : Identifiable {

}
