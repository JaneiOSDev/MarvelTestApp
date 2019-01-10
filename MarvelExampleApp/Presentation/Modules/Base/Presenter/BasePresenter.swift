//
//  BasePresenter.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

class BasePresenter<V: UIViewController>: Presenter {
    
    weak var viewController: V?
    let router: Router
    
    init(viewController: V, router: Router) {
        self.viewController = viewController
        self.router = router
    }
    
    // MARK: ViewLifecycleDelegate
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
}
