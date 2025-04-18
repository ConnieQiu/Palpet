//
//  FoodItem.swift
//  Palpet
//
//  Created by Connie Qiu on 10/21/23.
//

import Foundation
import UIKit

class FoodItem{
    let image: UIImage
    let goldCost: String
    let hungerRestoreValue: String
    
    init(image: UIImage, goldCost: String, hungerValue: String){
        self.image = image
        self.goldCost = goldCost
        self.hungerRestoreValue = hungerValue
    }
}
