//
//  ShopViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/21/23.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var foodImage: UIImageView!
    
    var items: [FoodItem] = []
    //still need to increment every time pet is fed
    var timesFed = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let itemImage = UIImage(named: "just apple icon") else {
            print("No image")
            abort()
        }
        
        let apple = FoodItem(image: itemImage, goldCost: "100g")
        let orange = FoodItem(image: itemImage, goldCost: "200g")
        let pear = FoodItem(image: itemImage, goldCost: "300g")

        
        print("Hello")
        items = [apple, orange, pear]
        
        if timesFed > 5 {
            addItemToShop()
        }

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //Add more items after a certain amount of feeds.
    func addItemToShop(){
        guard let itemImage = UIImage(named: "just apple icon") else {
            print("No image")
            abort()
        }
        let dragonfruit = FoodItem(image: itemImage, goldCost: "500g")
        items.append(dragonfruit)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItem", for: indexPath) as! FoodItemCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let customColor = UIColor(red: 248 / 255, green: 200 / 255 , blue: 220 / 255, alpha: 1.0)
        let cell = collectionView.cellForItem(at: indexPath) as! FoodItemCell
        cell.cellImage.layer.borderWidth = 1
        cell.cellImage.layer.borderColor = customColor.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FoodItemCell
        cell.cellImage.layer.borderWidth = 0
    }

}
