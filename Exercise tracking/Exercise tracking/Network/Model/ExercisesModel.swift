//
//  ExercisesModel.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation
import UIKit

struct ExercisesModel: Codable {
    var list: [[String]]?

    private enum CodingKeys: String, CodingKey {
        case list
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decodeIfPresent([[String]].self, forKey: .list)
    }
}
