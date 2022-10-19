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

    enum TypeOfController: String {
        case add
        case edit
    }

    private var exerciseName: String?
    private let networkManager = NetworkManager.shared
    private var typeOfController: TypeOfController = .add
    private var workoutItemModel: WorkoutItemModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
        setUpTextField()
        setUpButton()
    }

    @IBAction func tappedSaveChangesButton(_ sender: UIButton) {
        createWorkoutItem()
    }

    func setUp(with workoutItemModel: WorkoutItemModel, typeOfController: TypeOfController) {
        self.workoutItemModel = workoutItemModel
        self.exerciseName = workoutItemModel.name
        self.typeOfController = typeOfController
    }

    func setUp(with exerciseName: String, typeOfController: TypeOfController) {
        self.exerciseName = exerciseName
        self.typeOfController = typeOfController
    }

    private func setUpTextField() {
        if typeOfController == .edit {
            if let iterationsCount = workoutItemModel?.iterationsCount {
                textField.text = "\(iterationsCount)"
            }
        }
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        let isEmpty = textField.text?.isEmpty ?? true
        var isEnabled = !isEmpty

        if typeOfController == .edit {
            isEnabled = isEnabled && "\(workoutItemModel?.iterationsCount ?? 0)" != textField.text
        }
        saveChangesButton.isEnabled = isEnabled
        saveChangesButton.alpha = isEnabled ? 1 : 0.5
    }

    private func setUpButton() {
        saveChangesButton.layer.cornerRadius = 20
        saveChangesButton.setTitle(typeOfController == .edit ? "Update" : "Save changes",
                                   for: .normal)
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
