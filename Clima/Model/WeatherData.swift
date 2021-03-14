/**
 WeatherData.swift
 Clima
 - Author: Rob Ranf on 2/21/2021
 - Copyright © 2021 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import Foundation

/**
 - Note: Our structs need to conform to both the Encodable and Decodable protocols as we use the
 type alias "Codable" to refer to both. which is defined by Apple docs as "A type that can convert
 itself into and out of an external representation". Remember that encoding (serialization) and decoding
 (deserialization) are needed to pass any data (specifically an object) along a network, i.e. we are encoding
 our objects (structs) into a stream of bytes or decoding them from a stream of bytes to use in the app.
 */
struct WeatherData: Codable {
    let name: String
    let main: Main
    var weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
