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
}

extension ExerciseTracking: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://sport.iamprofessional.dev") else {
            fatalError()
        }
        return url
    }

    var path: String {
        switch self {
        case .exercise:
            return "/api/exercise"
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var method: Moya.Method {
        switch self {
        case .exercise:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .exercise:
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
