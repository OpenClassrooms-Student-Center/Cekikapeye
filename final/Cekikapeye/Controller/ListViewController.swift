//
//  ListViewController.swift
//  Cekikapeye
//
//  Created by Ambroise COLLON on 21/05/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit
import CoreData

final class ListViewController: UIViewController {

    // MARK: - Properties

    private let repository = SpendingRepository()
    private var spendings: [[Spending]] = []

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getSpendings()
    }

    // MARK: - Private

    private func getSpendings() {
        repository.getSpendings(callback: { [weak self] spending in
            self?.spendings = spending
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
        cell.detailTextLabel?.text = "\(spending.amount) \(SettingsRepository.currency)"

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // get the person's name
        guard let person = spendings[section].first?.person, let name = person.name else {
            return nil
        }

        // get spendings amount
        var totalAmount = 0.0
        for spending in spendings[section] {
            totalAmount += spending.amount
        }

        // return name, amount and currency
        return name + " (\(totalAmount) \(SettingsRepository.currency))"
    }

}
// delete cells
extension ListViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let spending = spendings[indexPath.section][indexPath.row]
            repository.remove(spending: spending, callback: { [weak self] in
                self?.getSpendings()
            })
        }
    }
}
