//
//  HomePresenter.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import Foundation


class HomePresenter:ViewToPresenterHomeProtocol{
    func getCountrySave(country: CountriesModel) {
    }
    
    var homeInteractor: PresenterToInteractorHomeProtocol?
    
    var homeView: PresenterToViewHomeProtocol?
    
    func getCountries() {
        homeInteractor?.getAllCountries()
    }
    
    
}

extension HomePresenter:InteractorToPresenterHomeProtocol{
    func dataToPresenter(countryListe: Array<CountriesModel>) {
        homeView?.sendDataToView(countryListe: countryListe)
        print("buraya geldi\(countryListe.count)")
    
    }
}

