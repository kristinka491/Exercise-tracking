//
//  ExerciseTableViewCell.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var rotatedView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
        // Initialization code
    }

    func setUp(_ exerciseName: String) {
        exerciseNameLabel.text = exerciseName
        exerciseImageView.image = Exercise(rawValue: exerciseName)?.image
    }

    private func setUpView() {
        myView.alpha = 0.2
        rotatedView.alpha = 0.1
        myView.layer.cornerRadius = 10
        rotatedView.layer.cornerRadius = 20
        rotatedView.transform = rotatedView.transform.rotated(by: .pi / 3)
    }
}
