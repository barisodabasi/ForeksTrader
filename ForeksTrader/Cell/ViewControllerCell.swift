//
//  ViewControllerCell.swift
//  ForeksTrader
//
//  Created by BarisOdabasi on 23.01.2022.
//

import UIKit

class ViewControllerCell: UITableViewCell {

   
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var upDownImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var selectedLabelFirst: UILabel!
    @IBOutlet weak var selectedLabelSecond: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
