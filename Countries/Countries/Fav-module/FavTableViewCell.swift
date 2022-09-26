//
//  FavTableViewCell.swift
//  Countries
//
//  Created by Ekin Atasoy on 24.09.2022.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var favCellView: UIView!
    
    @IBOutlet weak var favButtonView: UIButton!
    @IBOutlet weak var countryNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favCellView.layer.borderColor = UIColor.black.cgColor
        favCellView.layer.borderWidth = 2
        favCellView.layer.cornerRadius = 15
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favButton(_ sender: SavedModel) {
        
    }
    
}
