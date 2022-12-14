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
    case createWorkout(model: WorkoutItemModel)
    case deleteWorkout(id: Int)
    case updateWorkout(model: WorkoutItemModel)
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
        case .workoutItem, .createWorkout:
            return "workout-item"
        case .deleteWorkout(let id):
            return "workout-item/\(id)"
        case .updateWorkout(let model):
            return "workout-item/\(model.id ?? 0)"
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var method: Moya.Method {
        switch self {
        case .exercise, .workoutItem:
            return .get
        case .createWorkout, .updateWorkout:
            return .post
        case .deleteWorkout:
            return .delete
        }
    }

    var task: Task {
        switch self {
        case .exercise, .workoutItem, .deleteWorkout:
            return .requestPlain
        case .createWorkout(let model):
            let params = getParameters(model: model)
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateWorkout(let model):
            let params = getParameters(model: model)

            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }

    private func getParameters(model: WorkoutItemModel) -> [String: Any] {
        var params = [String: Any]()
        params["name"] = model.name
        params["timestamp"] = model.timestamp
        params["iterations_count"] = model.iterationsCount
        params["pause_before_item"] = 0
        params["user_id"] = currentUserId
        
        return params
    }
}
