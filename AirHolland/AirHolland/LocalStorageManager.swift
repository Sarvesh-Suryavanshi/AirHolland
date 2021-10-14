//
//  LocalStorageManager.swift
//  AirHolland
//
//  Created by Sarvesh Suryavanshi on 13/10/21.
//

import CoreData

/// Singleton class responsible for Managing Core Data Local Storage
class LocalStorageManager {
    
    //MARK: - Initializer

    private init() {  }

    //MARK: - Properties
    
    /// Shared Instance of LocalStorageManager
    static let shared = LocalStorageManager()
    
    /// Constant Strings
    ///
    private static let dataModelName = "AppDataModel"
    private static let RoasterEntityName = String(describing: Roaster.self)

    /// Creates and returns us persistent container
    private lazy var persistandContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: LocalStorageManager.dataModelName)
        container.loadPersistentStores { storeDescriptor, error in
            if let error = error {
                print("ERROR : \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    /// Returns us current app context
    var context: NSManagedObjectContext {
        return self.persistandContainer.viewContext
    }
    
    //MARK: - Functions

    /// Safely save context changes to core data
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
    
    /// Fetch Roaster Entity List from Core Data
    /// - Returns: Optional array of Roaster Entity
    func fetchLocalRoasterData() -> [Roaster]? {
        let request = NSFetchRequest<Roaster>(entityName: LocalStorageManager.RoasterEntityName)
        do {
            let result = try self.persistandContainer.viewContext.fetch(request)
            print(result.count)
            return result
        } catch {
            print("ERROR : \(error.localizedDescription)")
        }
        return nil
    }
    
    /// Performs Delete on all Roaster Entities stored in Core Data
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
