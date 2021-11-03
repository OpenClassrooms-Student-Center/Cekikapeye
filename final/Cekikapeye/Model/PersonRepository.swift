//
//  PersonRepository.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData


final class PersonRepository {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack

    // MARK: - Init

    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Repository

    func getPersons(callback: @escaping ([Person]) -> Void) {
        // create request
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        // execute request, ie get the saved data
        guard let persons = try? coreDataStack.viewContext.fetch(request) else {
            callback([])
            return
        }
        callback(persons)
    }

    func savePerson(named name: String, callback: @escaping () -> Void) {
        // create entity instance with context
        let person = Person(context: coreDataStack.viewContext)
        // use
        person.name = name
        do {
            try coreDataStack.viewContext.save()
            callback()
        } catch {
            print("We were unable to save \(name)")
        }
    }
}
