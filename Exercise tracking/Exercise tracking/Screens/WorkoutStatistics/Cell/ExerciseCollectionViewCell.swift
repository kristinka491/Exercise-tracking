//
//  ExerciseCollectionViewCell.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 17.10.2022.
//

import UIKit

class ExerciseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(_ exerciseName: String) {
        exerciseNameLabel.text = Exercise(rawValue: exerciseName)?.newNames
        exerciseImageView.image = Exercise(rawValue: exerciseName)?.collectionImage
    }

}
