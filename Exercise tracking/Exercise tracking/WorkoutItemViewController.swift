//
//  WorkoutItemViewController.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import UIKit

class WorkoutItemViewController: SetUpKeyboardViewController {

    @IBOutlet weak var exerciseNameLabel: UILabel!

    private var exerciseName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabel()
    }

    func setUp(with exerciseName: String) {
        self.exerciseName = exerciseName
    }

    private func setUpLabel() {
        exerciseNameLabel.text = exerciseName
    }
}
