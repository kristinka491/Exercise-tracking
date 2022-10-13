//
//  ApiError.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation

struct ApiErrors: Decodable {
    var errors: [ApiError]?

    private enum CodingKeys: String, CodingKey {
        case errors
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        errors = try container.decodeIfPresent([ApiError].self, forKey: .errors)
    }
}

struct ApiError: Decodable {
    var code: Int?
    var title: String?
    var detail: String?
    var errorCode: String?

    private enum CodingKeys: String, CodingKey {
        case code, title, detail, errorCode = "error_code"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decodeIfPresent(Int.self, forKey: .code)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        detail = try container.decodeIfPresent(String.self, forKey: .detail)
        errorCode = try container.decodeIfPresent(String.self, forKey: .errorCode)
    }
}
