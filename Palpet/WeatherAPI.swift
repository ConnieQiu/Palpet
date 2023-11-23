//
//  WeatherAPI.swift
//  Palpet
//
//  Created by Connie Qiu on 10/27/23.
//

import Foundation


struct OpenWeatherAPI{
    
    static let shared = OpenWeatherAPI()
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared){
        self.urlSession = urlSession
    }
    
    func getWeather(for city: String) async throws -> WeatherResponse{
        let apiKey = "ca02f2634dadc82ce57b53b9d2c830a0"
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)")!
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await urlSession.data(for: urlRequest)
    
        
        guard let response = response as? HTTPURLResponse else {
        
            throw OpenWeatherAPIError.requestFailed(message: "Response is not HTTPURLResponse.")
        }
       
        guard 200...202 ~= response.statusCode else {
            throw OpenWeatherAPIError.requestFailed(message: "Invalid city name")
            
        }
        
        let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        
        return weather

    }
    
    struct WeatherResponse: Codable{
        let weather: [Weather]
        
        struct Weather:Codable{
            let main: String
        }
    }
    
    
    
    enum OpenWeatherAPIError: Error{
        case requestFailed(message: String)
    }
}
