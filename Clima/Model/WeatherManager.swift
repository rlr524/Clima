/**
 WeatherManager.swift
 Clima
 - Author: Rob Ranf on 12/2/2020
 - Copyright © 2020 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

let apiID = (Bundle.main.infoDictionary?["API_ID"]as?String)!

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(String(describing: apiID))&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print("URI passed was: \(urlString)")
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        print("URI passed was: \(urlString)")
    }
    
    /**
     - Description:
     1. Create the URL
     2. Create a URL session
     3. Give the session a task and use a closure to handle errors and processing of safe data
     4. Start the task
     - Parameters: urlString points to our OpenWeatherMap api endpoint
     */
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            // Completion handler for api request task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let locationName = decodedData.name
            let description = decodedData.weather[0].description
            let weather = WeatherModel(conditionId: id, cityName: locationName, temperature: temp, description: description)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
