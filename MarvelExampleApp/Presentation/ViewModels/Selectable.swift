//
//  Selectable.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

typealias EmptyClosureType = () -> Void

protocol Selectable {
    var selectionClosure: EmptyClosureType { get set }
}
