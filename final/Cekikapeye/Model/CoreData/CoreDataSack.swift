//
//  CoreDataSack.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 08/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {

    // MARK: - Properties

    private let persistentContainerName = "Cekikapeye"

    // MARK: - Singleton

    static let sharedInstance = CoreDataStack()

    // MARK: - Public

    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }

    // MARK: - Private

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

