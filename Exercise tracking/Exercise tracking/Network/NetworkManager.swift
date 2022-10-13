//
//  NetworkManager.swift
//  Exercise tracking
//
//  Created by Vlad Birukov on 12.10.2022.
//

import Foundation
import Moya

class NetworkManager {
    static let shared = NetworkManager()

    func doRequest<T: Decodable>(target: MultiTarget, completion: ((T?, Error?) -> Void)?) {
        doRequest(target: target) { response, error in
            DispatchQueue.main.async {
                completion?(response?.object, error)
            }
        }
    }

    private func doRequest<T: Decodable>(target: MultiTarget,
                                         completion: ((LResponse<T>?, Error?) -> Void)?) {
        let provider = MoyaProvider<MultiTarget>()

        provider.request(target) { [weak self] result in
            switch result {
            case .success(let response):
                #if DEBUG
                debugPrint(response.request ?? "Can't unwrap")
                debugPrint(response.request?.allHTTPHeaderFields ?? "Can't unwrap")
                debugPrint(response.response ?? "Can't unwrap")
                #endif
                let result = self?.httpValidation(response: response)
                guard let data = result?.0 else {
                    completion?(nil, result?.1)
                    return
                }
                let jsonData = try? JSONSerialization.jsonObject(with: data)
                let json: Any? = jsonData as? [String: Any] ?? jsonData as? [Any] ?? nil
                var response: LResponse<T> = LResponse(object: nil, data: json, error: nil)
                debugPrint(json ?? "")
                guard let modelData = json else {
                    completion?(nil, result?.1)
                    return
                }
                guard let sself = self else {
                    return
                }

                DispatchQueue.global(qos: .userInitiated).async {
                    let expected: (T?, Error?) = sself.model(from: modelData)
                    guard let models = expected.0 else {
                        completion?(response, expected.1)
                        return
                    }
                    response.object = models
                    completion?(response, nil)
                }
            case .failure(let error):
                debugPrint(error)
                let response: LResponse<T> = LResponse(object: nil, data: nil, error: error as NSError)
                completion?(response, error)
            }
        }
    }

    private func httpValidation(response: Response) -> (Data?, Error?) {
        let httpValidator = HttpErrorValidator.isSucceeded(response)
        if httpValidator.0 {
            return (response.data, nil)
        } else {
            debugPrint(httpValidator.1 ?? "HTTP ERROR: Generic error")
            return (nil, httpValidator.1)
        }
    }

    private func model<T>(from payload: Any) -> (T?, Error?) where T: Decodable {
        let decoder = JSONDecoder()
        do {
            let json = try JSONSerialization.data(withJSONObject: payload, options: .prettyPrinted)
            let model = try decoder.decode(T.self, from: json)
            return (model, nil)
        } catch let error {
            debugPrint("\n Error JSON data: \(error)")
            return (nil, error)
        }
    }
}
