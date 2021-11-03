//
//  SettingsRepository.swift
//  Cekikapeye
//
//  Created by Morgan on 12/11/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import Foundation

struct SettingsRepository {

    // MARK: - Private

    private enum Keys {
        static let currency = "currency"
    }

    // MARK: - Public

    static var currency: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currency) ?? "€"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currency)
        }
    }
}
