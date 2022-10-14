//
//  ExerciseTracking.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 11.10.2022.
//

import Foundation
import Moya

enum ExerciseTracking {
    case exercise
    case workoutItem
}

extension ExerciseTracking: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://sport.iamprofessional.dev/api/") else {
            fatalError()
        }
        return url
    }

    var path: String {
        switch self {
        case .exercise:
            return "exercise"
        case .workoutItem:
            return "workout-item"
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var method: Moya.Method {
        switch self {
        case .exercise, .workoutItem:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .exercise, .workoutItem:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}
