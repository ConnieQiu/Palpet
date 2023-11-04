//
//  WeatherViewController.swift
//  Palpet
//
//  Created by Connie Qiu on 10/27/23.
//

import UIKit

protocol WeatherViewControllerDelegate: AnyObject{
    func weatherToMain(_ controller: WeatherViewController, didRecieveWeatherType weatherType: String)
}

class WeatherViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: WeatherViewControllerDelegate?
    
    @IBOutlet weak var userCityText: UITextField!
    
    var cityName: String?
    var weatherType = ""
    var previousWeatherType = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userCityText.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityName = textField.text
        
        if ((cityName?.isEmpty) != nil){
            print("Weather")
            Task{
                do {

                    let weatherData = try await OpenWeatherAPI.shared.getWeather(for: cityName ?? "default")
                    weatherType = weatherData.weather[0].main
                
                    print("type:" + weatherType)
                    
 
                    
                    //handle alerts
                    if weatherType == previousWeatherType{
                        let alertController = UIAlertController(title: "No change", message: "Weather is the same.", preferredStyle: .alert)
                    
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(action)
                        self.present(alertController, animated: true)
                        
                    }else{
                        let alertController = UIAlertController(title: "\(weatherType)", message: "Background changed!", preferredStyle: .alert)
                    
                        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(action)
                        self.present(alertController, animated: true)
                        //send data
                        sendDataToMainView(weather: weatherType)
                    }
                    textField.text = ""
                    previousWeatherType = weatherType
                
                } catch {
                    let alertController = UIAlertController(title: "Error", message: "Enter a valid city name", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true)
                    
                }
            }
            textField.resignFirstResponder()
        }
        print(cityName!)
        return true
    }
    
    func sendDataToMainView(weather: String){
        print("test")
        delegate?.weatherToMain(self, didRecieveWeatherType: weatherType)
        //performSegue(withIdentifier: "weatherToMain", sender: self)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        print("in prepare")
        if segue.identifier == "weatherToMain",
           let mainViewController = segue.destination as? MainScreenViewController{
            mainViewController.weather = weatherType
           print("about to send weather")
        }
    }*/

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
