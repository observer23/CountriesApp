//
//  HomeProtocols.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import Foundation


protocol ViewToPresenterHomeProtocol{
    var homeInteractor:PresenterToInteractorHomeProtocol?{get set}
    var homeView:PresenterToViewHomeProtocol?{get set}
    
    func getCountries()
}

protocol PresenterToInteractorHomeProtocol{
    var homePresenter:InteractorToPresenterHomeProtocol?{get set}
    func getAllCountries()
    
}

protocol InteractorToPresenterHomeProtocol{
    func dataToPresenter(countryListe:Array<CountriesModel>)
}

protocol PresenterToViewHomeProtocol{
    func sendDataToView(countryListe:Array<CountriesModel>)
}


protocol PresenterToRouterHomeProtocol{
    static func createModule(ref:HomeVC)
}
