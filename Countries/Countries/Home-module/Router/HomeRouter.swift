//
//  HomeRouter.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import Foundation


class HomeRouter:PresenterToRouterHomeProtocol{
    static func createModule(ref: HomeVC) {
        let presenter = HomePresenter()
        
        ref.homePresenterObject = presenter
        ref.homePresenterObject?.homeView = ref
        ref.homePresenterObject?.homeInteractor = HomeInteractor()
        ref.homePresenterObject?.homeInteractor?.homePresenter = presenter
    }
    
    
}
