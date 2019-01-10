//
//  ServerError.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import Foundation

struct ServerError: Error, Codable, CustomStringConvertible {
    
    let reason: String?
    let errorDescription: String?
    
    var description: String {
        return errorDescription ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case reason = "error"
        case errorDescription = "error_description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
        errorDescription = try values.decodeIfPresent(String.self, forKey: .errorDescription)
    }
}
