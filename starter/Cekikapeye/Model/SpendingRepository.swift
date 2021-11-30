//
//  SpendingRepository.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation

final class SpendingRepository {

    // MARK: - Properties
    
    private(set) var spendings = [Spending]()

    static let sharedInstance = SpendingRepository()

    // MARK: - Initializer

    private init() {}

    // MARK: - Repository

    func add(spending: Spending) {
        spendings.append(spending)
    }
}
