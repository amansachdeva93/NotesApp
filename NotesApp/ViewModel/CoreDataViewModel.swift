//
//  CoreDataViewModel.swift
//  NotesApp
//
//  Created by Amanpreet Singh on 29/05/23.
//

import Foundation
import CoreData
// MARK: - Core Data stack
class CoreDataViewModel: NSObject
{
    var container : NSPersistentContainer
    var noteList : [NoteEntity] = []
    
    override init()
    {
        container = NSPersistentContainer(name: "NotesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
              
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            else
            {
                print("successfully loaded core data")
            }
        })
    }
    
    func addNote(title: String, time: String, completion: (Bool) -> Void)
    {
       let entity = NoteEntity(context: container.viewContext)
        entity.title = title
        entity.time = time
        entity.status = false
        if saveContext(){
            completion(true) //saved successfully
        }
        else
        {
            completion(false) //if not saved..then return false
        }
    }
    
    func deleteNote(entity: NoteEntity, completion: (Bool) -> Void)
    {
        container.viewContext.delete(entity)
        if saveContext()
        {
            completion(true)
        }
        completion(false)
        
    }
    
    func updateNote(entity: NoteEntity, completion: (Bool) -> Void)
    {
        
        if saveContext()
        {
            completion(true)
        }
        completion(false)
        
    }
    
    func fetchList()
    {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        do{
            noteList = try container.viewContext.fetch(request)
            print("size: \(noteList.count)")
            
        }catch let error
        {
            print("error due to : \(error.localizedDescription)")
        }
    }
 
    func saveContext () -> Bool {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                let nserror = error as NSError
                return false
            }
        }
        return false
    }
}


