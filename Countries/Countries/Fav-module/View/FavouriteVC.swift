//
//  FavouriteVC.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import UIKit
var silinecek : SavedModel?
var fova = FavouriteVC()
class FavouriteVC: UIViewController {
    @IBOutlet weak var favTableView: UITableView!
    var savedList = [SavedModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.favTableView.delegate = self
        self.favTableView.dataSource  = self
    }
    override func viewWillAppear(_ animated: Bool) {
        getSavedList()
    }
    
    
    
}
extension FavouriteVC{
    func getSavedList(){
        let context = app.persistentContainer.viewContext
        do{
            let list = try context.fetch(SavedModel.fetchRequest())
            self.savedList = list
            print("bu\(list.count)")
            DispatchQueue.main.async {
                self.favTableView.reloadData()
            }
            
        }catch{
            print(String(describing: error))
        }
    }
}
extension FavouriteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let saved = savedList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! FavTableViewCell
        
        cell.countryNameLbl.text = "\(saved.name ?? "")"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saved = savedList[indexPath.row]
        context.delete(saved)
        app.saveContext()
        self.getSavedList()
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let saved = self.savedList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(saved.name!) silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){action in}
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){action in
                
                context.delete(saved)
                app.saveContext()
                self.getSavedList()
                
            }
            
            
            
            alert.addAction(iptalAction)
            alert.addAction(evetAction)
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
extension FavouriteVC{
    func deleteItem(){
        context.delete(silinecek!)
        app.saveContext()
        self.getSavedList()
    }
}
