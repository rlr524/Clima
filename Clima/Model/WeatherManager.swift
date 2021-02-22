/**
 WeatherManager.swift
 Clima
 - Author: Rob Ranf on 12/2/2020
 - Copyright © 2020 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=039de1f7c3eb63c700388ab529607ffc&units=metric"
    // TODO: Need to account for spaces in city names
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
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
                    self.parseJSON(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.name)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
}
