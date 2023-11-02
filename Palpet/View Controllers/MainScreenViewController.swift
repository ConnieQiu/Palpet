//
//  ViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/20/23.
//

import UIKit

class MainScreenViewController: UIViewController, WeatherViewControllerDelegate {
    
    @IBOutlet weak var rainyBackground: UIImageView!
    @IBOutlet weak var cloudyBackground: UIImageView!
    @IBOutlet weak var clearBackground: UIImageView!
    @IBOutlet weak var fullHealthBar: UIImageView!
    @IBOutlet weak var eightyHealthBar: UIImageView!
    @IBOutlet weak var sixtyHealthBar: UIImageView!
    @IBOutlet weak var fourtyHealthBar: UIImageView!
    @IBOutlet weak var twentyHealthBar: UIImageView!
    @IBOutlet weak var zeroHealthBar: UIImageView!
    
    /*var weather: String? {
        didSet{
            setWeather()
        }
    }*/
    
    var firstLoad = true
    
    var myPet: Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        if firstLoad == true{
            createPet()
            firstLoad = false
        }
        
        updateHunger()
    }
    
    
    
    func setUpUI(){
       
        let customColor = UIColor(red: 248 / 255, green: 200 / 255 , blue: 220 / 255, alpha: 1.0)
        
        if let tabBar = self.tabBarController?.tabBar{
           tabBar.backgroundColor = customColor
        }
        
    }

    
    // MARK: - Weather Method
    
    
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
    
    // MARK: - Pet Methods
    
    func createPet(){
        myPet = Pet();
       
    }
    
    func updateHunger(){
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true){
            timer in
            self.myPet.hunger -= 20
            //update health bar beloe here
            print("Pet hunger: " + String(self.myPet.hunger))
            self.fullHealthBar.isHidden = true
            self.eightyHealthBar.isHidden = true
            self.sixtyHealthBar.isHidden = true
            self.fourtyHealthBar.isHidden = true
            self.twentyHealthBar.isHidden = true
            self.zeroHealthBar.isHidden = true
            
            switch self.myPet.hunger{
                case 100:
                    self.fullHealthBar.isHidden = false
                case 80:
                    self.eightyHealthBar.isHidden = false
                case 60:
                    self.sixtyHealthBar.isHidden = false
                case 40:
                    self.fourtyHealthBar.isHidden = false
                case 20:
                    self.twentyHealthBar.isHidden = false
                case 0:
                    self.zeroHealthBar.isHidden = false
                default:
                    self.fullHealthBar.isHidden = false
            }
            
            if self.myPet.hunger == 0 {
                timer.invalidate()
            }
        }

    }

}


