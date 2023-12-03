//
//  ShopViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/21/23.
//

import UIKit

protocol ShopViewControllerDelegate: AnyObject{
    func feedButton(withHungerNum hungerNum: Int)
}

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playerGoldAmount: UILabel!
    @IBOutlet weak var hungerRestoreValue: UILabel!
    @IBOutlet weak var feedButton: UIButton!
    
    weak var delegate: ShopViewControllerDelegate?
    
    //send hunger value to MainScreenViewController if pet is not full
    @IBAction func feedButtonUsed(_ sender: UIButton) {
        if(!Pet.shared.isFull && currentItemPriceInt < Player.shared.gold || !Pet.shared.isFull && currentItemPriceInt == Player.shared.gold){
            delegate?.feedButton(withHungerNum: currentItemHungerValueInt)
            let intNewPlayerGold: Int
            intNewPlayerGold = Player.shared.gold - currentItemPriceInt
            playerGoldAmount.text = String(intNewPlayerGold)
            Player.shared.gold = intNewPlayerGold
            timesFed += 1
            if timesFed > 0 && itemAlreadyAdded == false{
                addItemToShop()
            }
            
        }else if(!Pet.shared.isFull && currentItemPriceInt > Player.shared.gold){
            let alertController = UIAlertController(title: "", message: "Not enough gold!", preferredStyle: .alert)
        
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        else{
            let alertController = UIAlertController(title: "", message: "Pet already full!", preferredStyle: .alert)
        
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        
        //print("New player gold amount label: " + (playerGoldAmount.text ?? "0"))
        //print("New player gold amount: " + String(myPlayer.gold))
        
    }
    
    var items: [FoodItem] = []
    var timesFed = 0
    var isFirstLoad = true
    var myPlayer: Player!
    var currentItemPriceInt = 0
    var currentItemHungerValueInt = 0
    var itemAlreadyAdded = UserDefaults.standard.bool(forKey: "itemAddedOrNot")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let cherryItemIcon = UIImage(named: "cherry-icon") else {
            print("No image")
            abort()
        }
        
        guard let grapeItemIcon = UIImage(named: "grape-icon")else{
            print("No image")
            abort()
        }
        
        guard let strawberryItemIcon = UIImage(named: "strawberry-icon")else{
            print("No image")
            abort()
        }
        
        let cherry = FoodItem(image: cherryItemIcon, goldCost: "100g", hungerValue: "20")
        let grape = FoodItem(image: grapeItemIcon, goldCost: "200g", hungerValue: "40")
        let strawberry = FoodItem(image: strawberryItemIcon, goldCost: "300g", hungerValue: "60")

        
        items = [cherry, grape,strawberry]
        feedButton.isEnabled = false
        

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if isFirstLoad == true{
            myPlayer = Player()
            isFirstLoad = false
            //print("playerGold " + String(myPlayer.gold) )
        }
        
        if(itemAlreadyAdded == true){
            addItemToShop()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerGoldAmount.text = String(Player.shared.gold)
        if Player.shared.gold == 0 || Player.shared.gold < 0 {
            feedButton.isEnabled = false
        }
    }
    
    //Add more items after a certain amount of feeds.
    func addItemToShop(){
        
        if(itemAlreadyAdded == false){
            let alertController = UIAlertController(title: "Congratulations", message: "New food added to shop!", preferredStyle: .alert)
    
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        itemAlreadyAdded = true
        guard let itemImage = UIImage(named: "apple-icon") else {
            print("No image")
            abort()
        }
        let apple = FoodItem(image: itemImage, goldCost: "500g", hungerValue: "80")
        items.append(apple)
        UserDefaults.standard.set(itemAlreadyAdded, forKey: "itemAddedOrNot")
        print("item added?: \(UserDefaults.standard.bool(forKey: "itemAddedOrNot"))")
        collectionView.reloadData()
    }
    
    // MARK: - Collection View
    
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
        
        let currentItemPriceString = cell.itemGoldCost.text?.dropLast() ?? "0"
        currentItemPriceInt = Int(currentItemPriceString) ?? 0
        
        let currentItemHungerValueString = cell.restoreHungerValue.text ?? "0"
        currentItemHungerValueInt = Int(currentItemHungerValueString) ?? 0
        feedButton.isEnabled = true
        
        //print("Gold price: " + String(currentItemPriceInt))
        //print("Hunger value: " + String(currentItemHungerValueInt))
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FoodItemCell
        cell.cellImage.layer.borderWidth = 0
        feedButton.isEnabled = false
    }
}
