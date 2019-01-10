//
//  Comics.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import Foundation

struct Comics: Codable {
    
    let title: String?
    enum CodingKeys: String, CodingKey {
        case title
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}
