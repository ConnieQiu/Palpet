//
//  FoodItemCollectionCell.swift
//  Palpet
//
//  Created by Connie Qiu on 10/21/23.
//

import Foundation
import UIKit

class FoodItemCell: UICollectionViewCell{
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var itemGoldCost: UILabel!
    @IBOutlet weak var restoreHungerValue: UILabel!
    
    func configure(with model: FoodItem){
        cellImage.image = model.image
        itemGoldCost.text = model.goldCost
        restoreHungerValue.text = model.hungerRestoreValue
    }
    
    
}
