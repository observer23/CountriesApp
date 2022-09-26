//
//  HomeInteractor.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import Foundation

class HomeInteractor:PresenterToInteractorHomeProtocol{
    var homePresenter: InteractorToPresenterHomeProtocol?
    
    func getAllCountries() {
        let context = app.persistentContainer.viewContext
                do{
                    let list = try context.fetch(CountriesModel.fetchRequest())
                    homePresenter?.dataToPresenter(countryListe: list)
                    print("Interactor ToPresenter:\(list.count)")
                }catch{
                    print(String(describing: error))
                }
    }
        
}


