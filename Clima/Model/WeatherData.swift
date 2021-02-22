/**
 WeatherData.swift
 Clima
 - Author: Rob Ranf on 2/21/2021
 - Copyright © 2021 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import Foundation

/**
 - Note: Our structs need to conform to the Decodable protocol
 */
struct WeatherData: Decodable {
    let name: String
    let main: Main
    var weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
