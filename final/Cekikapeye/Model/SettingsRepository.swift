//
//  SettingsRepository.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 08/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import Foundation

final class SettingsRepository {

    // MARK: - Private

    private enum Keys {
        static let currency = "currency"
    }

    // MARK: - Public

    var currency: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.currency) ?? "€"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.currency)
        }
    }
}
