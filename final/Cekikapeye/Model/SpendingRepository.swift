//
//  SpendingRepository.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation
import CoreData

final class SpendingRepository {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack

    // MARK: - Init

    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }

    // MARK: - Repository

    func getSpendings(callback: @escaping ([[Spending]]) -> Void) {
        // create request
        let request: NSFetchRequest<Spending> = Spending.fetchRequest()
        request.sortDescriptors = [
        NSSortDescriptor(key: "person.name", ascending: true),
        NSSortDescriptor(key: "amount", ascending: true)]
        // execute request, ie get the saved data
        guard let spendings = try? coreDataStack.viewContext.fetch(request) else {
            callback([])
            return
        }
        callback(spendings.convertedToArrayOfArray)
    }

    func saveSpending(with content: String, amount: Double, for person: Person, callback: @escaping () -> Void) {
        // create entity in a context
        let spending = Spending(context: coreDataStack.viewContext)
        // give values to its properties
        spending.content = content
        spending.amount = amount
        // use relationship attribute to get a value
        spending.person = person
        // save context
        do {
            try coreDataStack.viewContext.save()
            callback()
        } catch {
            print("We were unable to save \(spending)")
        }
    }

    func remove(spending: Spending, callback: @escaping () -> Void) {
        coreDataStack.viewContext.delete(spending)
        do {
            try coreDataStack.viewContext.save()
            callback()
        } catch {
            print("We were unable to remove \(spending.description)")
        }
    }
}

private extension Array where Element == Spending {
    var convertedToArrayOfArray: [[Spending]] {
        var dict = [Person: [Spending]]()

        for spending in self where spending.person != nil {
            dict[spending.person!, default: []].append(spending)
        }

        var result = [[Spending]]()
        for (_, val) in dict {
            result.append(val)
        }

        return result
    }
}
