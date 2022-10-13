//
//  HttpErrorValidator.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation
import Moya

class HttpErrorValidator {

    static func isSucceeded(_ response: Response) -> (Bool, Error?) {
        switch response.statusCode {
        case 200: return (true, nil)
        default:
            if let apiError = try? JSONDecoder().decode(ApiErrors.self, from: response.data).errors?.first {
                let error = NSError(domain: "HTTP Error",
                                    code: response.statusCode,
                                    userInfo: [NSLocalizedDescriptionKey: apiError.detail ?? "General Error"])
                return (false, error)
            } else {
                let jsonDict = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                var detailsString: String?
                if let arrayElement = (jsonDict?["errors"] as? [Any])?.first,
                    let dict = arrayElement as? [String: Any],
                    let details = dict["detail"] as? [String: Any] {
                    detailsString = (details.compactMap({ (key, value) -> String in
                        let description = (value as? [String: Any])?["wrong_value"]
                        return "\(key) - \(description ?? "")"
                    }) as Array).joined(separator: ";")
                }

                debugPrint("Invalid response\n\(String(describing: jsonDict))")
                let error = NSError(domain: "HTTP Error",
                                    code: response.statusCode,
                                    userInfo: [NSLocalizedDescriptionKey: detailsString ?? "Invalid response"])
                return (false, error)
            }
        }
    }
}
