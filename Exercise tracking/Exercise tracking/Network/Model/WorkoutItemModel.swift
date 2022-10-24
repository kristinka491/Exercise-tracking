//
//  WorkoutItemModel.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 14.10.2022.
//

import UIKit

struct WorkoutListModel: Codable {
    var list: [WorkoutItemModel]?

    private enum CodingKeys: String, CodingKey {
        case list
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decodeIfPresent([WorkoutItemModel].self, forKey: .list)
    }
}

struct WorkoutItemModel: Codable {
    var name: String?
    var iterationsCount: Int?
    var timestamp: Int?
    var userId: String?
    var id: Int?

    private enum CodingKeys: String, CodingKey {
        case name, iterationsCount = "iterations_count", timestamp, userId = "user_id", id = "pk"
    }

    init(exerciseName: String?) {
        name = exerciseName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        iterationsCount = try container.decodeIfPresent(Int.self, forKey: .iterationsCount)
        timestamp = try container.decodeIfPresent(Int.self, forKey: .timestamp)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }
}
