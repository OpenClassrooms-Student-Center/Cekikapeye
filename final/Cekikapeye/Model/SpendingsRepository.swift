//
//  SpendingsRepository.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

final class SpendingsRepository {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack

    // MARK: - Init

    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Repository

    func getSpendings(completion: ([[Spending]]) -> Void) {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Person.name, ascending: true),
        ]
        do {
            let spendings = try coreDataStack.viewContext.fetch(request)
            completion(spendings.spendingsByPerson)
        } catch {
            completion([])
        }
    }

    func addSpending(with amount: Double, content: String, for person: Person, completion: () -> Void) {
        let spending = Spending(context: coreDataStack.viewContext)
        spending.amount = amount
        spending.content = content
        spending.person = person
        do {
            try coreDataStack.viewContext.save()
            completion()
        } catch {
            print("We were unable to save \(spending)")
        }
    }

    func remove(spending: Spending, completion: () -> Void) {
        coreDataStack.viewContext.delete(spending)
        do {
            try coreDataStack.viewContext.save()
            completion()
        } catch {
            print("We were unable to remove \(spending.description)")
        }
    }
}

private extension Array where Element == Person {
    var spendingsByPerson: [[Spending]] {
        return self.compactMap {
            ($0.spendings?.allObjects as? [Spending])?.sorted(by: {$0.amount < $1.amount} )
        }
    }
}
