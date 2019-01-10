//
//  Router.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

class Router: NSObject {
    
    fileprivate(set) weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension Router {
    
    func transit(to view: UIViewController) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        UIView.transition(with: window,
                          duration: 0.0,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: {
                            window.rootViewController = view
        },
                          completion: nil)
    }
}
