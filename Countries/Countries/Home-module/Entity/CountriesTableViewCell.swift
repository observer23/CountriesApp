//
//  CountriesTableViewCell.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import UIKit
import CoreData
class CountriesTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var buttonView: UIButton!
    var buttonIsSelected : Bool?{
        
            didSet {
                if buttonIsSelected == true {
                    buttonView.setImage(UIImage(systemName: "star.fill"), for: .normal)
                    print("Star fill")
                } else {
                    buttonView.setImage(UIImage(systemName: "star"), for: .normal)
                    print("Star")
                }
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.borderColor = UIColor.black.cgColor
        cellView.layer.borderWidth = 2
        cellView.layer.cornerRadius = 15
        buttonIsSelected = false
        
        
        
    }
    @IBAction func favButton(_ sender: Any) {
        /*
        if buttonView.currentImage == UIImage(systemName: "star.fill"){
            buttonIsSelected = false
        }else{
            buttonIsSelected = true
        }*/
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
