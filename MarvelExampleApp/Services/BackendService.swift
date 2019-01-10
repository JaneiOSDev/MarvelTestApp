//
//  DataService.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import Foundation
import Alamofire

class BackendService {
    
    var client: AlamofireHttpClient
    
    static let reachabilityManager = NetworkReachabilityManager()
    
    init() {
        client = AlamofireHttpClient(baseUrl: defaultURL)
    }
    
    init(with url: URL) {
        client = AlamofireHttpClient(baseUrl: url)
    }
    
    private let defaultURL: URL = {
        let url: URL
        url = URL(string: "http://gateway.marvel.com/v1/")!
        
        return url
    }()
    
    let publicKey = "d77ecbaa600331433c49ebca58a39c9d"
    let privateKey = "d07999a242da208dcfae0f2b84514d0facb15934"
    
    func hash(_ ts: TimeInterval) -> String {
        //md5(ts+privateKey+publicKey)
        let string = "\(ts)\(privateKey)\(publicKey)"
        print(string)
        let data = string.data(using: .utf8)
        if let hash = data?.md5() {
            print("hash: \(hash)")
            return hash
        }
        
        return ""
    }
}

