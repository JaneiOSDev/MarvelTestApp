//
//  CellDescribable.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

protocol CellDescribable {
    static var nib: UINib? { get }
    static var identifier: String { get }
}

extension CellDescribable {
    
    static var nib: UINib? {
        let mainBundle = Bundle.main
        if mainBundle.path(forResource: String(describing: self), ofType: "nib") != nil {
            return UINib(nibName: String(describing: self), bundle: nil)
        }
        return nil
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
