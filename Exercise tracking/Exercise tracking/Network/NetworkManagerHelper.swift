//
//  NetworkManagerHelper.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation
import Moya

let currentUserId = "1780538723"

extension NetworkManager {

    func exercise(completion: ((ExercisesModel?, Error?) -> Void)?) {
        let exerciseRequest = ExerciseTracking.exercise
        doRequest(target: MultiTarget(exerciseRequest), completion: completion)
    }

    func workoutItem(completion: ((WorkoutListModel?, Error?) -> Void)?) {
        let workoutItemRequest = ExerciseTracking.workoutItem
        doRequest(target: MultiTarget(workoutItemRequest), completion: completion)
    }
}
