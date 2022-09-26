//
//  DetailVC.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import UIKit
import SafariServices

var savedListe=[String:Bool]()
var savedVar = Bool()
var detailvm:DetailVC?
class DetailVC: UIViewController {
    
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    var country : CountriesModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = country?.name!
        countryFlagImageView.layer.borderColor = UIColor.black.cgColor
        countryFlagImageView.layer.borderWidth = 2
        countryFlagImageView.layer.cornerRadius = 15
        countryFlagImageView.image = UIImage(named: (country?.name!)!)
        
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20.0)!
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 20.0)!
        ]
        let boldText = NSAttributedString(string: "Country Code:", attributes: boldAttribute)
        let regularText = NSAttributedString(string: "    \((country?.code)!)", attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(regularText)
        countryCodeLabel.attributedText = newString
    }
    override func viewWillAppear(_ animated: Bool) {
        savedVar = false
        starCheck()
        if savedVar {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star.fill")
            navigationItem.rightBarButtonItem?.tintColor = .black

        }else{
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "star")
            navigationItem.rightBarButtonItem?.tintColor = .black

        }
    }
    @IBAction func moreInfoButton(_ sender: Any) {
        if let url = NSURL(string: "https://www.wikidata.org/wiki/\((country?.wikiDataId!)!)"){
            let dest = SFSafariViewController(url: url as URL)
            present(dest, animated: true, completion: nil)
        }
    }
    
    @IBAction func favButton(_ sender: UIBarButtonItem) {
        favourite()
    }
}
extension DetailVC{
    func starCheck(){
        let context = app.persistentContainer.viewContext
        do{
            let list = try context.fetch(SavedModel.fetchRequest())
            var a = [String]()
            for i in list{
                a.append("\(i.name!)")
            }
            if a.contains("\((country?.name)!)"){
                savedVar = true
            }
        }catch{
            print(String(describing: error))
        }
        app.saveContext()
    }
    func favourite(){
        let rightButton = navigationItem.rightBarButtonItem
        let star = UIImage(systemName: "star")
        let starFill = UIImage(systemName: "star.fill")
        
        let context = app.persistentContainer.viewContext
        do{
            let list = try context.fetch(SavedModel.fetchRequest())
            var a = [String]()
            for i in list{
                a.append("\(i.name!)")
            }
            if a.contains("\((country?.name)!)"){
                rightButton?.image = star
            }else{
                rightButton?.image = starFill
                let newC = SavedModel(context: context)
                newC.currencyCodes = country?.currencyCodes
                newC.name = country?.name
                newC.code = country?.code
                newC.wikiDataId = country?.wikiDataId
            }
        }catch{
            print(String(describing: error))
        }
        app.saveContext()
    }
    func addFav(){
        let context = app.persistentContainer.viewContext
        do{
            let list = try context.fetch(SavedModel.fetchRequest())
            var a = [String]()
            for i in list{
                a.append("\(i.name!)")
            }
            if a.contains("\((country?.name)!)"){
                print("ZAten var.")
            }else{
                let newC = SavedModel(context: context)
                newC.name = country?.name
            }
        }catch{
            print(String(describing: error))
        }
        app.saveContext()
        
    }
    
    
}
