//
//  PeopleTableViewController.swift
//  Cekikapeye
//
//  Created by Ambroise COLLON on 24/05/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

import UIKit
import CoreData

final class PeopleViewController: UIViewController {

    // MARK: - Properties

    private let repository = PersonRepository()

    // MARK: - Outlets

    @IBOutlet private weak var peopleTextView: UITextView!
    @IBOutlet private weak var peopleTextField: UITextField!

    // MARK: - Actions

    @IBAction private func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        getPeople()
    }

    // MARK: - Private

    private func getPeople() {
        repository.getPersons(callback: { [weak self] persons in
            var peopleText = ""
            for person in persons {
                if let name = person.name {
                    peopleText += name + "\n"
                }
            }
            self?.peopleTextView.text = peopleText
        })
    }
}

extension PeopleViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addPerson()
        return true
    }

    private func addPerson() {
        guard let personName = peopleTextField.text, var people = peopleTextView.text else {
            return
        }
        repository.savePerson(named: personName, callback: { [weak self] in
            people += personName + "\n"
            self?.peopleTextView.text = people
            self?.peopleTextField.text = ""
        })
    }
}
