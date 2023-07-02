//
//  CoreDataManager.swift
//  FavouritePlace
//
//  Created by Oladipupo Oluwatobi on 02/07/2023.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init () {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        $0.loadPersistentStores { _, err in
            if let err = err as? NSError {
                fatalError("Error: \(err), \(err.userInfo)")
            }
        }
        return $0
    }(NSPersistentContainer(name: "FavouritePlacesDM"))
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let err {
                 let error = err as NSError
                    fatalError("Error saving context: \(error), \(error.userInfo)")
                
            }
        }
    }
    
    func getAll() -> [Place] {
        var places = [Place]()
        let placeRequest: NSFetchRequest<Place> = Place.fetchRequest()
        do {
            places =  try context.fetch(placeRequest)
        } catch let err as NSError {
            print(err.localizedDescription)
        }
        return places
    }
    
    func save(name: String, notes: String, city: String,country: String, imageData: Data) {
        let place = Place(context: context)
        place.id = UUID()
        place.name = name
        place.city = city
        place.country = country
        place.notes = notes
        place.image = imageData
        
        saveContext()
        
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        do {
            let fetchContext = try context.fetch(fetchRequest)
            guard let place = fetchContext.first(where: {$0.id == id}) else {return}
            context.delete(place)
            saveContext()
        } catch let err as NSError {
            print(err.localizedDescription)
        }
    }
}
