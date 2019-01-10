//
//  MainViewPresenter.swift
//  MarvelExampleApp
//
//  Created by Evgeniya Pervushina on 1/10/19.
//  Copyright © 2019 AirDev. All rights reserved.
//

import UIKit

final class MainViewPresenter: BasePresenter<MainViewController> {
    
    let mainInfoService: MainInfoService
    private var fields: [Comics] = [Comics]() {
        didSet {
            configureView()
        }
    }
    
    init(viewController: MainViewController,
         router: Router,
         mainInfoService: MainInfoService) {
        
        self.mainInfoService = mainInfoService
        
        super.init(viewController: viewController, router: router)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getFields()
    }
    
    private func configureView() {
        
        let viewModels = fields.map({ field -> MainInfoComicsModel in
            return MainInfoComicsModel(name: field.title ?? "",
                                       selectionClosure: {
                                        self.handleSelection()
            })
        })
        let section = SectionViewModel(items: viewModels)
        let collection = CollectionViewModel(sections: [section])
        viewController?.viewModel = collection
    }
    
    private func handleSelection() {
        //some
    }
    
    private func getFields() {
        //some progress indicator start
        
        self.mainInfoService.getComics()
            .done { [weak self] resultData in
                if resultData.count > 0 {
                    self?.fields = resultData
                }
                
                }.catch { error in
                    
                }.finally {
                    //some progress indicator stop
            }
    }
}
