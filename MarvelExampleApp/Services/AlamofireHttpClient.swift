//
//  AlamofireHttpClient.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class AlamofireHttpClient {
    
    let baseUrl: URL
    var headers: [String: String] = [:]
    
    required init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    // MARK: Headers
    
    func addHeader(_ name: String, value: String) {
        headers[name] = value
    }
    
    func removeHeader(_ name: String) {
        headers[name] = nil
    }
    
    // MARK: Url
    
    fileprivate func absolutePath(_ relativePath: String) -> URL {
        guard !relativePath.isEmpty else {return baseUrl}
        assert(relativePath.first != "/", "'/' symbol at the begining of url relativePath will cause 'RestrictedIP' error")
        guard let url = URL(string: relativePath, relativeTo: baseUrl) else {
            assertionFailure("failed to construct url for path \(relativePath)")
            return baseUrl
        }
        return url
    }
    
    // MARK: Requests
    
    func get(path: String, parameters: [String: Any]?) -> Promise<[String: Any]> {
        return self.request(.get, path: path, parameters: parameters, encoding: URLEncoding.default)
    }
    
    func post(path: String, parameters: [String: Any]?) -> Promise<[String: Any]> {
        return self.request(.post, path: path, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    func delete(path: String, parameters: [String: Any]?) -> Promise<[String: Any]> {
        return self.request(.delete, path: path, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    func patch(path: String, parameters: [String: Any]?) -> Promise<[String: Any]> {
        return self.request(.patch, path: path, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    private func request(_ method: HTTPMethod,
                         path: String,
                         parameters: [String: Any]?,
                         encoding: ParameterEncoding) -> Promise<[String: Any]> {
        let url = absolutePath(path)
        print("url: \(url)")
        return Promise<[String: Any]> { seal in
            Alamofire.request(url,
                              method: method,
                              parameters: parameters,
                              encoding: encoding,
                              headers: self.headers)
                .validate(contentType: ["application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    #if DEBUG
                    print(response)
                    #endif
                    switch response.result {
                        
                    case .success(let json):
                        if let json = json as? [String: Any] {
                            seal.fulfill(json)
                        } else if let json = json as? [Any] {
                            seal.fulfill(["items": json])
                        } else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                    case .failure(let error):
                        guard   let data = response.data,
                            let serverError = try? JSONDecoder().decode(ServerError.self, from: data) else {
                                seal.reject(error)
                                return
                        }
                        seal.reject(serverError)
                    }
            }
        }
    }
    
}

