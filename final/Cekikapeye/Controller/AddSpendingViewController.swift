//
//  AddSpendingViewController.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import UIKit

final class AddSpendingViewController: UIViewController {

    // MARK: - Properties

    private let spendingsRepository = SpendingsRepository()
    private let peopleRepository = PeopleRepository()
    private var people: [Person] = []

    // MARK: - Outlets

    @IBOutlet private weak var contentTextField: UITextField!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var personPickerView: UIPickerView!

    // MARK: - View life cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPersons()
    }

    private func getPersons() {
        peopleRepository.getPersons(completion: { [weak self] people in
            self?.people = people
            self?.personPickerView.reloadAllComponents()
        })
    }

    // MARK: - Actions

    @IBAction private func save() {
        guard
            let content = contentTextField.text,
            let amountText = amountTextField.text,
            let amount = Double(amountText),
            let person = getSelectedPerson()
        else { return }
        spendingsRepository.addSpending(
            with: amount,
            content: content,
            for: person,
            completion: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }

    private func getSelectedPerson() -> Person? {
        if !people.isEmpty {
            let index = personPickerView.selectedRow(inComponent: 0)
            return people[index]
        }
        return nil
    }
}

extension AddSpendingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].name
    }
}

extension AddSpendingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func hideKeyboard(_ sender: UITapGestureRecognizer) {
        contentTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }
}
