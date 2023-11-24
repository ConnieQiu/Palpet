//
//  WeatherCell.swift
//  Palpet
//
//  Created by Connie Qiu on 11/23/23.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    static let identifier = "WeatherCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "WeatherCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
