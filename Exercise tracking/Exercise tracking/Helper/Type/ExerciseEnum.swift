//
//  ExerciseEnum.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 13.10.2022.
//

import Foundation
import UIKit

enum Exercise: String, Codable {
    case legsRaises = "legs_raises"
    case pullUps = "pull-ups"
    case pushUps = "push-ups"
    case tabata = "tabata"

    var image: UIImage? {
        switch self {
        case .legsRaises:
            return UIImage(named: "legs_raises")
        case .pullUps:
            return UIImage(named: "pull-ups")
        case .pushUps:
            return UIImage(named: "push-ups")
        case .tabata:
            return UIImage(named: "tabata")
        }
    }
}
