/**
 WeatherModel.swift
 Clima
 - Author: Rob Ranf on 3/12/2021
 - Copyright © 2021 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import Foundation

/**
 - Description: Note the difference between conditionId, cityName, and temperature which are
 stored properties vs the conditionName or tempString which are computed properties. Like in Vue, we use a
 computed property when we want to manipulate data (e.g. do something with a stored property)
 but we don't specifically need a method to do so. A computed property must be a var.
 */
struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var tempString: String {
        return String(format: "%.1f", temperature)
    }
    
    // TODO: Drill down on the OpenWeatherMap codes (e.g. haze specifics, rain types, etc.)
    var conditionName: String {
        switch conditionId {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...899:
            return "cloud"
        default:
            return "questionmark.diamond"
        }
    }
}
