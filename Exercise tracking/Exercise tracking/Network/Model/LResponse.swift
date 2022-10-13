//
//  LResponse.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation

struct LResponse<T: Decodable> {
    var object: T?
    var data: Any?
    var error: NSError?
}
