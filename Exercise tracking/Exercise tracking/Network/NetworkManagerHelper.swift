//
//  NetworkManagerHelper.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation
import Moya

let currentUserId = "12"

extension NetworkManager {

    func exercise(completion: ((ExercisesModel?, Error?) -> Void)?) {
        let exerciseRequest = ExerciseTracking.exercise
        doRequest(target: MultiTarget(exerciseRequest), completion: completion)
    }

    func workoutItems(completion: ((WorkoutListModel?, Error?) -> Void)?) {
        let workoutItemRequest = ExerciseTracking.workoutItem
        doRequest(target: MultiTarget(workoutItemRequest), completion: completion)
    }

    func createWorkout(model: WorkoutItemModel,
                 completion: ((StatusModel?, Error?) -> Void)?) {
        let workoutRequest = ExerciseTracking.createWorkout(model: model)
        doRequest(target: MultiTarget(workoutRequest), completion: completion)
    }

    func deleteWorkout(id: Int, completion: ((StatusModel?, Error?) -> Void)?) {
        let deleteWorkoutRequest = ExerciseTracking.deleteWorkout(id: id)
        doRequest(target: MultiTarget(deleteWorkoutRequest), completion: completion)
    }

    func updateWorkout(model: WorkoutItemModel, completion: ((StatusModel?, Error?) -> Void)?) {
        let updateWorkoutRequest = ExerciseTracking.updateWorkout(model: model)
        doRequest(target: MultiTarget(updateWorkoutRequest), completion: completion)
    }
}
