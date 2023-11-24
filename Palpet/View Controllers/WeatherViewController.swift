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

class WeatherViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: WeatherViewControllerDelegate?
    
    @IBOutlet weak var userCityText: UITextField!
    @IBOutlet weak var weatherTableView: UITableView!
    
    
    var cityName: String?
    var weatherType = ""
    var previousWeatherType = ""
    var items: [WeatherData] = []
    var maxItemsInWeatherTable = 8
    
    /*
     Source for Custom Table View Cell:
     https://www.youtube.com/watch?v=OOc-RhNQnLc
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userCityText.delegate = self
        
        
        /*let completeWeatherData = WeatherData(city: cityName ?? "none", degreeNum: "50", weatherCondition: "Clouds")
        items.append(completeWeatherData)
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.register(WeatherDataTableViewCell.self, forCellReuseIdentifier: "weatherData")*/

        let completeWeatherData = WeatherData(city: "test city", weatherCondition: "Clouds")
        items.append(completeWeatherData)
        //weatherTableView.register(WeatherDataTableViewCell.self, forCellReuseIdentifier: "WeatherTableCell")
        weatherTableView.register(WeatherCell.nib(), forCellReuseIdentifier: WeatherCell.identifier)
        weatherTableView.reloadData()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
       

    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        cityName = textField.text
        
        if ((cityName?.isEmpty) != nil){
            print("Weather")
            Task{
                do {
                    
                    let weatherData = try await OpenWeatherAPI.shared.getWeather(for: cityName ?? "default")
                    //print("testing")
                    weatherType = weatherData.weather[0].main
                
                    print("type:" + weatherType)
                    if(items.count >= 8){
                        items.removeFirst()
                    }
                    let completeWeatherData = WeatherData(city: cityName ?? "none", weatherCondition: weatherType)
                    items.append(completeWeatherData)
                    //weatherTableView.dataSource = self
                    //weatherTableView.delegate = self
                    weatherTableView.register(WeatherCell.nib(), forCellReuseIdentifier: WeatherCell.identifier)
                    /*weatherTableView.register(WeatherDataTableViewCell.self, forCellReuseIdentifier: WeatherCell.identifier /*"WeatherTableCell"*/)*/
                    print("items in array: \(items.count)")
                    weatherTableView.reloadData()
                   
                    
                    
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

    

    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier/*"WeatherTableCell"*/, for: indexPath) as! WeatherCell/*WeatherDataTableViewCell*/
        print("TESTING IN TABLEVIEW")
        print(items[indexPath.row].cityName)
        //cell.configure(with: items[indexPath.row])
        /*cell.cityLabel.text = items[indexPath.row].cityName
        print("UMMM?")
        cell.degree.text = items[indexPath.row].degree
        cell.weatherType.text = items[indexPath.row].weatherType*/
        cell.cityLabel.text = items[indexPath.row].cityName
        cell.weatherLabel.text = items[indexPath.row].weatherType
        
        return cell
    }
    



   

}
