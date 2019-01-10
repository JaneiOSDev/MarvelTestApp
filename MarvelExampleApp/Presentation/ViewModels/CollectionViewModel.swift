//
//  CollectionViewModel.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

struct CollectionViewModel {
    let sections: [SectionViewModel]
}

struct SectionViewModel {
    let items: [Any]
}
