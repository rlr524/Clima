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
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    
    func performRequest(urlString: String) {
        // Create the URL
        if let url = URL(string: urlString) {
            // Create a URL session
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            // Start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString ?? "There is no data")
        }
    }
}
