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

    private let spendingRepository = SpendingRepository()
    private let personRepository = PersonRepository()
    private var persons: [Person] = []

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
        personRepository.getPersons(callback: { [weak self] persons in
            self?.persons = persons
            self?.personPickerView.reloadAllComponents()
        })
    }

    // MARK: - Actions

    @IBAction private func save() {
        guard
            let content = contentTextField.text,
            let amountText = amountTextField.text,
            let amount = Double(amountText),
            let selectedPerson = getPerson()
        else { return }

        spendingRepository.saveSpending(
            with: content,
            amount: amount,
            for: selectedPerson,
            callback: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }

    private func getPerson() -> Person? {
        if !persons.isEmpty {
            let index = personPickerView.selectedRow(inComponent: 0)
            return persons[index]
        } else {
            return nil
        }
    }
}

extension AddSpendingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return persons.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return persons[row].name
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
