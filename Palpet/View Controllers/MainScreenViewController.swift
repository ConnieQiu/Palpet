//
//  ViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/20/23.
//  General Source: UIKit Apprentice Beginning iOS Development with Swift
//  Source for UserDefaults: https://stackoverflow.com/questions/31203241/how-can-i-use-userdefaults-in-swift

import UIKit

class MainScreenViewController: UIViewController, WeatherViewControllerDelegate, ShopViewControllerDelegate{
    
    @IBOutlet weak var rainyBackground: UIImageView!
    @IBOutlet weak var cloudyBackground: UIImageView!
    @IBOutlet weak var clearBackground: UIImageView!
    @IBOutlet weak var fullHealthBar: UIImageView!
    @IBOutlet weak var eightyHealthBar: UIImageView!
    @IBOutlet weak var sixtyHealthBar: UIImageView!
    @IBOutlet weak var fourtyHealthBar: UIImageView!
    @IBOutlet weak var twentyHealthBar: UIImageView!
    @IBOutlet weak var zeroHealthBar: UIImageView!
    @IBOutlet weak var petImage: UIImageView!
    
    var firstLoad = true
    
    var hungerValueNum = 0
    
    override func viewWillAppear(_ animated: Bool) {
            self.petImage.alpha = 0.3
        
            UIView.animate(withDuration: 0.2){
                self.petImage.alpha = 1
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        if firstLoad == true{
            firstLoad = false
        }
        
        startTimer()
        petImage.isHidden = true
        
        if let tabBarController = self.tabBarController as? TabBarViewController{
            let shopViewController = tabBarController.viewControllers?[2] as? ShopViewController
            shopViewController?.delegate = self
        }
        if(Pet.shared.hunger != 0){
            petImage.isHidden = false
            repeatBlinkAnimation()
            petBlinkAnimation()
            repeatEarAnimation()
            petEarAnimation()
        }
        saveDataTimer()
        saveData()
        updateHunger()
            
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(Pet.shared.hunger == 0){
            petImage.layer.removeAllAnimations()
            let alertController = UIAlertController(title: "Pet died :(", message: "You will keep all previous gold when restarting.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Restart", style: .default){
                (action) in
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                UserDefaults.standard.synchronize()
                Pet.shared.isFull = true
                self.zeroHealthBar.isHidden = true
                self.fullHealthBar.isHidden = false
                Pet.shared.hunger = 100
                self.repeatEarAnimation()
                self.petBlinkAnimation()
                self.repeatBlinkAnimation()
                self.petEarAnimation()
                self.petImage.alpha = 0
                self.petImage.isHidden = false
                UIView.animate(withDuration: 5){
                    self.petImage.alpha = 1
                }
                
            }
            alertController.addAction(action)
            self.present(alertController, animated: true)
            
        }
    }

    func setUpUI(){
       
        let customColor = UIColor(red: 248 / 255, green: 200 / 255 , blue: 220 / 255, alpha: 1.0)
        
        if let tabBar = self.tabBarController?.tabBar{
           tabBar.backgroundColor = customColor
        }
        
        clearBackground.isHidden = UserDefaults.standard.bool(forKey: "clearBackground")
        cloudyBackground.isHidden = UserDefaults.standard.bool(forKey: "cloudyBackground")
        rainyBackground.isHidden = UserDefaults.standard.bool(forKey: "rainyBackground")
        
    }
    
    /*Source for animations:
     https://stackoverflow.com/questions/2834573/how-to-animate-the-change-of-image-in-an-uiimageview
     */
    
    func repeatBlinkAnimation(){
        Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(petBlinkAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func petBlinkAnimation(){
        //print("blink animating")
        let eyesOpen = UIImage(named: "fixedpet")?.cgImage
        let eyesClosed = UIImage(named: "pet-blink")?.cgImage
        let blinkAnimation: CABasicAnimation = CABasicAnimation(keyPath: "contents")
        
        blinkAnimation.fromValue = eyesOpen
        blinkAnimation.toValue = eyesClosed
        blinkAnimation.duration = 0.4
        petImage.layer.add(blinkAnimation, forKey: "contents")
        
        
    }
    
    func repeatEarAnimation(){
        Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(petEarAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func petEarAnimation(){
        //print("ear animating")
        let regularImage = UIImage(named: "fixedpet")?.cgImage
        let movedEarsImage = UIImage(named: "pet-moved-ears")?.cgImage
        let earAnimation: CABasicAnimation = CABasicAnimation(keyPath: "contents")
        
        earAnimation.fromValue = regularImage
        earAnimation.toValue = movedEarsImage
        earAnimation.duration = 0.4
        petImage.layer.add(earAnimation, forKey: "contents")
        
        
    }
    
    func saveDataTimer(){
        Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(saveData), userInfo: nil, repeats: true)
    }
    
    @objc func saveData(){
        UserDefaults.standard.set(Player.shared.gold, forKey: "Gold")
        UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
        //print("saveData main controller")
    }

    
    // MARK: - Delegate Methods
    
    
    func weatherToMain(_ controller: WeatherViewController, didRecieveWeatherType weatherType: String) {
        
        print("Received weather: \(weatherType)")
        //weather = weatherType
        
        if weatherType == "Clouds"{
            clearBackground.isHidden = true
            cloudyBackground.isHidden = false
            rainyBackground.isHidden = true
            UserDefaults.standard.set(clearBackground.isHidden, forKey: "clearBackground")
            UserDefaults.standard.set(cloudyBackground.isHidden, forKey: "cloudyBackground")
            UserDefaults.standard.set(rainyBackground.isHidden, forKey: "rainyBackground")
            
        }else if weatherType == "Clear" {
            clearBackground.isHidden = false
            cloudyBackground.isHidden = true
            rainyBackground.isHidden = true
            UserDefaults.standard.set(clearBackground.isHidden, forKey: "clearBackground")
            UserDefaults.standard.set(cloudyBackground.isHidden, forKey: "cloudyBackground")
            UserDefaults.standard.set(rainyBackground.isHidden, forKey: "rainyBackground")
        }else if weatherType == "Rain"{
            clearBackground.isHidden = true
            cloudyBackground.isHidden = true
            rainyBackground.isHidden = false
            UserDefaults.standard.set(clearBackground.isHidden, forKey: "clearBackground")
            UserDefaults.standard.set(cloudyBackground.isHidden, forKey: "cloudyBackground")
            UserDefaults.standard.set(rainyBackground.isHidden, forKey: "rainyBackground")
        }
        
    }
    
    
    func feedButton(withHungerNum hungerNum: Int) {
        print("hunger total: " + String(Pet.shared.hunger + hungerNum))
        if Pet.shared.hunger <= 100 && (Pet.shared.hunger + hungerNum) <= 100{
            hungerValueNum = hungerNum
            Pet.shared.hunger += hungerValueNum
            print("inside feedButton: " + String(Pet.shared.hunger))
            updateHunger()
            
        }else if Pet.shared.hunger <= 100 && (Pet.shared.hunger + hungerNum) > 100{
            Pet.shared.hunger = 100
            print("inside else if: " + String(Pet.shared.hunger))
            updateHunger()
        }
        updateHunger()
    }
    
    // MARK: - Pet Methods

    func startTimer(){
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true){
            timer in
            if Pet.shared.hunger != 0{
                Pet.shared.hunger -= 20
                print("before update: \(UserDefaults.standard.integer(forKey: "PetHunger"))")
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                Pet.shared.isFull = false
                //print("Pet hunger: " + String(Pet.shared.hunger))
            }
            self.updateHunger()
        }
    }
    
    func updateHunger(){
        
        self.fullHealthBar.isHidden = true
        self.eightyHealthBar.isHidden = true
        self.sixtyHealthBar.isHidden = true
        self.fourtyHealthBar.isHidden = true
        self.twentyHealthBar.isHidden = true
        self.zeroHealthBar.isHidden = true
        
        switch UserDefaults.standard.integer(forKey: "PetHunger"){
            case 100:
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                UserDefaults.standard.synchronize()
                self.fullHealthBar.isHidden = false
                Pet.shared.isFull = true
                //print("saving pet hunger")
            case 80:
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                UserDefaults.standard.synchronize()
                self.eightyHealthBar.isHidden = false
                Pet.shared.isFull = false
                print("saving pet hunger")
            case 60:
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
            UserDefaults.standard.synchronize()
                self.sixtyHealthBar.isHidden = false
                Pet.shared.isFull = false
                print("saving pet hunger")
            case 40:
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                UserDefaults.standard.synchronize()
                self.fourtyHealthBar.isHidden = false
                Pet.shared.isFull = false
                print("saving pet hunger")
            case 20:
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                UserDefaults.standard.synchronize()
                self.twentyHealthBar.isHidden = false
                Pet.shared.isFull = false
                print("saving pet hunger")
            case 0:
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                UserDefaults.standard.synchronize()
                print("pet hunger in case 0: \(Pet.shared.hunger)")
                self.zeroHealthBar.isHidden = false
                Pet.shared.isFull = false
                self.petImage.isHidden = true
                print("saving pet hunger")
                let alertController = UIAlertController(title: "Pet died :(", message: "You will keep all previous gold when restarting.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Restart", style: .default){
                    (action) in
                    Pet.shared.hunger = 100
                    UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                    UserDefaults.standard.synchronize()
                    Pet.shared.isFull = true
                    self.zeroHealthBar.isHidden = true
                    self.fullHealthBar.isHidden = false
                    self.petImage.alpha = 0
                    self.petImage.isHidden = false
                    UIView.animate(withDuration: 2.5){
                        self.petImage.alpha = 1
                    }
                }
                print("in case 0: \(Pet.shared.hunger)")
                alertController.addAction(action)
                self.present(alertController, animated: true)
            default:
                self.fullHealthBar.isHidden = false
        }
        print("after update: \(UserDefaults.standard.integer(forKey: "PetHunger"))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UserDefaults.standard.set(Player.shared.gold, forKey: "Gold")
        UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
    }
}


