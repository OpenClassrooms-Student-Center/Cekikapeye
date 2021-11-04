//
//  PeopleTableViewController.swift
//  Cekikapeye
//
//  Created by Bertrand BLOC'H on 03/11/2021.
//  Copyright © 2021 OpenClassrooms. All rights reserved.
//

import UIKit

final class PeopleViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var peopleTextView: UITextView!
    @IBOutlet private weak var peopleTextField: UITextField!

    // MARK: - Actions

    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension PeopleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addPerson()
        return true
    }

    private func addPerson() {
        guard
            let personName = peopleTextField.text,
            var people = peopleTextView.text
        else { return }

        people += personName + "\n"
        peopleTextView.text = people
        peopleTextField.text = ""

        // TODO: Save person
    }
}
