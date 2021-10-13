//
//  LocalStorageManager.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 13/10/21.
//

import Foundation
import CoreData

class LocalStorageManager {
    
    static let shared = LocalStorageManager()
    
    private init() {  }
    
    private lazy var persistandContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppDataModel")
        container.loadPersistentStores { storeDescriptor, error in
            if let error = error {
                print("ERROR : \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistandContainer.viewContext
    }
    
    func save() {
        let managedObjectContext = self.persistandContainer.viewContext
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("ERROR : \(error.localizedDescription)")
            }
        }
    }
    
    func fetchLocalRoasterData() -> [Roaster]? {
        let request = NSFetchRequest<Roaster>(entityName: "Roaster")
        do {
            let result = try self.persistandContainer.viewContext.fetch(request)
            print(result)
            return result
        } catch {
            print("ERROR : \(error.localizedDescription)")
        }
        return nil
    }
    
    func deleteAllLocalRoasterData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Roaster")
        let batchDeleteRequest =  NSBatchDeleteRequest(fetchRequest: request)
        do {
            try self.persistandContainer.viewContext.execute(batchDeleteRequest)
            self.save()
        } catch {
            print("ERROR : \(error.localizedDescription)")
        }
    }
}
