//
//  HomeVC.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import UIKit
let context = app.persistentContainer.viewContext
class HomeVC: UIViewController {
    
    @IBOutlet weak var CountriesTableView: UITableView!
    
    var homePresenterObject:ViewToPresenterHomeProtocol?
    var vc:HomeVC?
    
    var countryList = [CountriesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do{
            let list = try context.fetch(CountriesModel.fetchRequest())
            if list.isEmpty{
                getAll()
                print("Eeee")
                
            }
        }catch{
            print(String(describing: error))
        }
        
        CountriesTableView.delegate = self
        CountriesTableView.dataSource = self
        HomeRouter.createModule(ref: self)
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(named: "general")
        
        renkDegistir(itemApperance: appearance.stackedLayoutAppearance)
        renkDegistir(itemApperance: appearance.inlineLayoutAppearance)
        renkDegistir(itemApperance: appearance.compactInlineLayoutAppearance)
        
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.scrollEdgeAppearance = appearance
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        homePresenterObject?.getCountries()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let country = sender as? CountriesModel{
                let destinationVC = segue.destination as! DetailVC
                destinationVC.country = country
            }
        }
    }
    
    
}
extension HomeVC:PresenterToViewHomeProtocol{
    
    func sendDataToView(countryListe: Array<CountriesModel>) {
        self.countryList = countryListe
        DispatchQueue.main.async {
            self.CountriesTableView.reloadData()
        }
        
        print("Buraya geldi.")
    }
}

extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countryList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountriesTableViewCell
        
        cell.countryNameLabel.text = "\(country.name!)"
        let context = app.persistentContainer.viewContext
        do{
            let list = try context.fetch(SavedModel.fetchRequest())
            var a = [String]()
            for i in list{
                a.append("\(i.name!)")
            }
            if a.contains("\((country.name)!)"){
                cell.buttonIsSelected = true
                print("ZAten var.")
            }else{
                cell.buttonIsSelected = false
            }
        }catch{
            print(String(describing: error))
        }
        app.saveContext()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countryList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: country)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let country = self.countryList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(country.name!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){action in}
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){action in
                
                context.delete(country)
                app.saveContext()
                self.homePresenterObject?.getCountries()
            }
            
            
            
            alert.addAction(iptalAction)
            alert.addAction(evetAction)
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}



extension HomeVC{
    
    
    func getAll() {
        let headers = [
            "X-RapidAPI-Key": "a1922a4a16mshacf38435862c390p1aa9e0jsn12954c3994c0",
            "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://wft-geo-db.p.rapidapi.com/v1/geo/countries?limit=10")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("Burası:\(error!)")
            } else {
                if let safeData=data{
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString)
                    self.parseJSON(cityData: safeData)
                }
            }
        })
        
        dataTask.resume()
        
    }
    func parseJSON(cityData:Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CountriesData.self, from: cityData)
            //print(decodedData.data[9].currencyCodes[0])
            for i in 0...9{
                let newCountry=CountriesModel(context: context)
                newCountry.code = decodedData.data[i].code
                newCountry.name = decodedData.data[i].name
                newCountry.currencyCodes = decodedData.data[i].currencyCodes[0]
                newCountry.wikiDataId = decodedData.data[i].wikiDataId
                app.saveContext()
                print("Yaptı")
            }
            self.homePresenterObject?.getCountries()
            
        }catch{
            print("Bu: \(String(describing: error))")
        }
        
    }
    func renkDegistir(itemApperance:UITabBarItemAppearance){
        itemApperance.selected.iconColor = UIColor.black
        itemApperance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        itemApperance.selected.badgeBackgroundColor = UIColor.red
        
        itemApperance.normal.iconColor = UIColor.darkGray
        itemApperance.normal.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        itemApperance.normal.badgeBackgroundColor = UIColor.red
        
    }
}
