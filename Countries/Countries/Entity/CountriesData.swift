//
//  Countries.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import Foundation


struct CountriesData:Decodable{
    var data:[CountryData]
    
}
struct CountryData:Decodable{
    let code:String
    let name:String
    let currencyCodes:[String]
    let wikiDataId:String
}

