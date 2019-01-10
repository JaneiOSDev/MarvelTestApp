//
//  MainInfoService.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit
import PromiseKit

class MainInfoService: BackendService {
    
    private let comicsPath     = "public/comics"
    
    override init() {
        super.init()
        
        client.addHeader("Accept", value: "*/*")
    }
    
    func getComics() -> Promise<[Comics]> {
        let ts = Date().timeIntervalSince1970
        
        let pharameters = ["apikey": self.publicKey,
                           "ts" : ts,
                           "hash" : self.hash(ts)] as [String : Any]
        
        return Promise { seal in
            return client.get(path: comicsPath, parameters: pharameters)
                .compactMap(on: .global(), { (response) -> Void in
                    
                    print(response)
                    guard let dataJSON = response["data"] as? [String:Any],
                        let resultJSON = dataJSON["results"] else {
                        let error = SerializationError(errorDescription: "no items founds while parsing response for path \(self.comicsPath)")
                        throw AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error))
                    }
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: resultJSON)
                    let decoder = JSONDecoder()
                    let array = try decoder.decode([Comics].self, from: jsonData)
                    
                    seal.fulfill(array)
                })
                .catch { error in
                    seal.reject(error)
            }
        }
    }
    
}
