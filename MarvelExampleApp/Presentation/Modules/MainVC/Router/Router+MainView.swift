//
//  Router+MainView.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

private let mainStoryboard = "Main"

extension Router {
    
    static func instantiateMainView() -> UIViewController {
        
        let storyboard = UIStoryboard(name: mainStoryboard, bundle: nil)
        let view = storyboard.instantiateInitialViewController() as! MainViewController
        let router =  Router(view: view)
        let mainInfoService = MainInfoService()
        let presenter = MainViewPresenter(viewController: view,
                                            router: router,
                                            mainInfoService: mainInfoService)
        view.presenter = presenter
        return view
    }
}
