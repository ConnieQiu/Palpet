//
//  ViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/20/23.
//

import UIKit


class MainScreenViewController: UIViewController, WeatherViewControllerDelegate, ShopViewControllerDelegate {
    
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
    
    
    /*var weather: String? {
        didSet{
            setWeather()
        }
    }*/
    
    var firstLoad = true
    
    //var myPet: Pet!
    
    var hungerValueNum = 0
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        if firstLoad == true{
            //createPet()
            firstLoad = false
        }
        
        startTimer()
        
        
        if let tabBarController = self.tabBarController as? TabBarViewController{
            let shopViewController = tabBarController.viewControllers?[2] as? ShopViewController
            shopViewController?.delegate = self
        }
        repeatBlinkAnimation()
        petBlinkAnimation()
        repeatEarAnimation()
        petEarAnimation()
        saveDataTimer()
        saveData()
        updateHunger()

    }
    

    func setUpUI(){
       
        let customColor = UIColor(red: 248 / 255, green: 200 / 255 , blue: 220 / 255, alpha: 1.0)
        
        if let tabBar = self.tabBarController?.tabBar{
           tabBar.backgroundColor = customColor
        }
        
    }
    
    func repeatBlinkAnimation(){
        Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(petBlinkAnimation), userInfo: nil, repeats: true)
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
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(saveData), userInfo: nil, repeats: true)
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
            
        }else if weatherType == "Clear" {
            clearBackground.isHidden = false
            cloudyBackground.isHidden = true
            rainyBackground.isHidden = true
        }else if weatherType == "Rain"{
            clearBackground.isHidden = true
            cloudyBackground.isHidden = true
            rainyBackground.isHidden = false
        }
        
    }
    
    /*func setWeather(_ myWeather: String){
        print("in set weather")
        print("is weather: " + weather)
  
        if myWeather == "Clouds"{
            clearBackground.isHidden = true
            cloudyBackground.isHidden = false
        }else if myWeather == "Clear" {
            clearBackground.isHidden = false
            cloudyBackground.isHidden = true
        }
    }*/
    
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
    
    /*func createPet(){
        myPet = Pet();
       
    }*/
    
    func startTimer(){
        Timer.scheduledTimer(withTimeInterval: 20, repeats: true){
            timer in
            if Pet.shared.hunger != 0{
                Pet.shared.hunger -= 20
                print("before update: \(UserDefaults.standard.integer(forKey: "PetHunger"))")
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                Pet.shared.isFull = false
                //update health bar beloe here
                //print("Pet hunger: " + String(Pet.shared.hunger))
            }
            self.updateHunger()
            /*if Pet.shared.hunger == 0 {
                timer.invalidate()
            }*/
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
                self.fullHealthBar.isHidden = false
                Pet.shared.isFull = true
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                //print("saving pet hunger")
            case 80:
                self.eightyHealthBar.isHidden = false
                Pet.shared.isFull = false
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                print("saving pet hunger")
            case 60:
                self.sixtyHealthBar.isHidden = false
                Pet.shared.isFull = false
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                print("saving pet hunger")
            case 40:
                self.fourtyHealthBar.isHidden = false
                Pet.shared.isFull = false
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                print("saving pet hunger")
            case 20:
                self.twentyHealthBar.isHidden = false
                Pet.shared.isFull = false
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                print("saving pet hunger")
            case 0:
                self.zeroHealthBar.isHidden = false
                Pet.shared.isFull = false
                UserDefaults.standard.set(Pet.shared.hunger, forKey: "PetHunger")
                print("saving pet hunger")
            default:
                self.fullHealthBar.isHidden = false
        }
        print("after update: \(UserDefaults.standard.integer(forKey: "PetHunger"))")
    }
    

}


