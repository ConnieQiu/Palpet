//
//  WeatherData.swift
//  Palpet
//
//  Created by Connie Qiu on 11/24/23.
//

import Foundation
import UIKit

class WeatherData{
    
    let cityName: String
    let weatherType: String
    
    init(city: String, weatherCondition: String){
        self.cityName = city
        self.weatherType = weatherCondition
    }
}
