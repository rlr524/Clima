/**
 WeatherManager.swift
 Clima
 - Author: Rob Ranf on 12/2/2020
 - Copyright © 2020 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=039de1f7c3eb63c700388ab529607ffc&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    // TODO: Need to account for spaces in city names
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print("URI passed was: \(urlString) ")
    }
    
    /**
     - Description:
     1. Create the URL
     2. Create a URL session
     3. Give the session a task and use a closure to handle errors and processing of safe data
     4. Start the task
     - Parameters: urlString points to our OpenWeatherMap api endpoint
     */
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
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
            print(error)
            return nil
        }
    }
}
