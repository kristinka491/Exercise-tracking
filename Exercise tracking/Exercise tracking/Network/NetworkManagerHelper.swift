//
//  NetworkManagerHelper.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation
import Moya

extension NetworkManager {

    func exercise(completion: ((ExercisesModel?, Error?) -> Void)?) {
        let exerciseRequest = ExerciseTracking.exercise
        doRequest(target: MultiTarget(exerciseRequest), completion: completion)
    }


}
