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
    case workout(iterationsCount: Int, timeStamp: Int, name: String)
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
        case .workoutItem, .workout:
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
        case .workout:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .exercise, .workoutItem:
            return .requestPlain
        case .workout(let iterationsCount,
                      let timeStamp,
                      let name):
            var params = [String: Any]()
            params["name"] = name
            params["timestamp"] = timeStamp
            params["iterations_count"] = iterationsCount
            params["pause_before_item"] = 0
            params["user_id"] = currentUserId
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}
