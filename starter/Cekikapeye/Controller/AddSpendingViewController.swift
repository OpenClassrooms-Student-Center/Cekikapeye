//
//  AddSpendingViewController.swift
//  Cekikapeye
//
//  Created by Ambroise COLLON on 21/05/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit

final class AddSpendingViewController: UIViewController {

    // MARK: - Properties

    private let spendingRepository = SpendingRepository()

    // MARK: - Outlets

    @IBOutlet private weak var contentTextField: UITextField!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var personPickerView: UIPickerView!

    // MARK: - Actions

    @IBAction private func save() {
        guard let content = contentTextField.text,
            let amountText = amountTextField.text,
            let amount = Double(amountText) else {
                return
        }

        let spending = Spending(content: content, amount: amount)
        spendingRepository.add(spending: spending)
        navigationController?.popViewController(animated: true)
    }
}

extension AddSpendingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ""
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
