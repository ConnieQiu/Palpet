//
//  WeatherDataTableViewCell.swift
//  Palpet
//
//  Created by Connie Qiu on 11/23/23.
//

import Foundation
import UIKit

class WeatherDataTableViewCell: UITableViewCell{
    /*@IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var weatherType: UILabel!*/
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    //static let identifier = "WeatherTableViewCell"
    
    func configure(with model: WeatherData){
        print("city name model: \(model.cityName)")
        cityLabel.text = model.cityName
        degree.text = model.degree
        weatherType.text = model.weatherType
    }
    
}
