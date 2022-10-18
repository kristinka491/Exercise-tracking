//
//  WorkoutItemViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import UIKit

class WorkoutItemViewController: SetUpKeyboardViewController {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var saveChangesButton: UIButton!


    private var exerciseName: String?
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        setUpTextField()
    }

    @IBAction func tappedSaveChangesButton(_ sender: UIButton) {
        createWorkoutItem()
    }

    func setUp(with exerciseName: String) {
        self.exerciseName = exerciseName
    }

    private func setUpTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isEmpty = textField.text?.isEmpty ?? true
        saveChangesButton.isEnabled = !isEmpty
        saveChangesButton.alpha = isEmpty ? 0.5 : 1
    }

    private func setUpLabel() {
        exerciseNameLabel.text = Exercise(rawValue: exerciseName ?? "")?.newNames

    }

    private func createWorkoutItem() {
        guard let name = exerciseName,
              let numberOfIterations = Int(textField.text ?? "") else {
                  return
              }

        let alertVC = showLoader()
        networkManager.workout(name: name,
                               iterationsCount: numberOfIterations,
                               timeStamp: Int(Date().timeIntervalSince1970)) { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            if model?.status == "ok" {
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
