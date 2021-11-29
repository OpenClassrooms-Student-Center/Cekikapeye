//
//  ListViewController.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    // MARK: - Properties

    private let spendingsRepository = SpendingsRepository()
    private let settingsRepository = SettingsRepository()
    private lazy var spendings: [[Spending]] = []

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSpendings()
    }

    private func getSpendings() {
        spendingsRepository.getSpendings(completion: { [weak self] spendings in
            self?.spendings = spendings
            self?.tableView.reloadData()
        })
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return spendings.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spendings[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath)

        let spending = spendings[indexPath.section][indexPath.row]
        cell.textLabel?.text = spending.content
        cell.detailTextLabel?.text = "\(spending.amount) \(settingsRepository.currency)"

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let person = spendings[section].first?.person else { return nil }

        var totalAmount = 0.0
        for spending in spendings[section] {
            totalAmount += spending.amount
        }

        return "\(person.name ?? "🧙‍♂️") \(totalAmount) \(settingsRepository.currency)"
    }
}

extension ListViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let spending = spendings[indexPath.section][indexPath.row]
            spendingsRepository.remove(spending: spending, completion: { [weak self] in
                self?.getSpendings()
            })
        }
    }
}
