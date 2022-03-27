//
//  ManagedObjectContext.swift
//  TODOLIST_GRUPO4
//
//  Created by SP11601 on 26/03/22.
//

import Foundation
import UIKit
import CoreData

typealias onCompletionHandler = (String) -> Void

protocol managedProtocol {
    func getTasks() -> [Task]
}

protocol managedSaveProtocol {
    func save(task: Task, onCompletionHandler: onCompletionHandler)
}

protocol managedDeleteProtocol {
    func delete(uuid: String, onCompletionHandler: onCompletionHandler)
}

class ManagedObjectContext: managedProtocol, managedSaveProtocol, managedDeleteProtocol {
    
    private let entity = "Tasks"
    
    static let shared: ManagedObjectContext = {
        let instance = ManagedObjectContext()
        return instance
    }()

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func getTasks() -> [Task] {
        var tasksList: [Task] = []
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        do {
            guard let tasks = try getContext().fetch(fetchRequest) as? [NSManagedObject] else { return tasksList }
            
            for item in tasks {
                
                if let id = item.value(forKey: "id") as? UUID,
                   let title = item.value(forKey: "title") as? String,
                   let description = item.value(forKey: "descript") as? String,
                   let completed = item.value(forKey: "completed") as? Bool {

                    let task = Task(id: id, title: title, description: description, completed: completed)
                    
                    tasksList.append(task)
                }
                
            }
            
        } catch let error as NSError {
            print("Error in request \(error.localizedDescription)")
        }
        
        return tasksList
    }

    func save(task: Task, onCompletionHandler: (String) -> Void) {
        
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else { return }
        let transaction = NSManagedObject(entity: entity, insertInto: context)
        
        transaction.setValue(task.id, forKey: "id")
        transaction.setValue(task.title, forKey: "title")
        transaction.setValue(task.description, forKey: "descript")
        transaction.setValue(task.completed, forKey: "completed")
        
        do {
            try context.save()
            onCompletionHandler("Save Success")
            
        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    func update(task: Task, onCompletionHandler: (String) -> Void) {
        let context = getContext()
        
        let predicate = NSPredicate(format: "id == %@","\(task.id.uuidString)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>=NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if let entityExists = fetchResult.first {
                entityExists.setValue(task.title, forKey: "title")
                entityExists.setValue(task.description, forKey: "descript")
                entityExists.setValue(task.completed, forKey: "completed")
                try context.save()
                onCompletionHandler("Save Success")
            }
            
        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
    }

    func delete(uuid: String, onCompletionHandler: (String) -> Void) {
        
        let context = getContext()
        let predicate = NSPredicate(format: "id == %@","\(uuid)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>=NSFetchRequest(entityName: entity)
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if let entityDelete = fetchResult.first {
                context.delete(entityDelete)
            }
            
            try context.save()
            
            onCompletionHandler("Delete Success")
            
        } catch let error as NSError {
            
            print("Fetch failed \(error.localizedDescription)")
            
        }
    }
            
}
