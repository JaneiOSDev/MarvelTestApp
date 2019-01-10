//
//  SerializationError.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import Foundation

struct SerializationError: Error, CustomStringConvertible {
    let errorDescription: String
    
    var description: String {
        return errorDescription
    }
}
