//
//  WeatherData.swift
//  Palpet
//
//  Created by Connie Qiu on 11/23/23.
//

import Foundation
import UIKit

class WeatherData{
    
    let cityName: String
    let degree: String
    let weatherType: String
    
    init(city: String, degreeNum: String, weatherCondition: String){
        self.cityName = city
        self.degree = degreeNum
        self.weatherType = weatherCondition
    }
}
