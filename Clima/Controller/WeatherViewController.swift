/**
 ViewController.swift
 Clima
 - Author: Rob Ranf on 12/2/2020
 - Copyright © 2020 Emiya Consulting. All rights reserved
 - Version 0.1
 */

import UIKit

/**
 - Note: We are adopting the UITextFieldDelegate protocol here and in our delegate methods, we are conforming to the protocol
 */
class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var unitsToggle: UISwitch!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         - Note: We are setting the current ViewController as the delegate for our searchTextField outlet. This allows our searchTextField to communicate with the entire view controller (it can be notified and respond to changes in the vc such as keyboard presses)...this allows us to use our textFieldShouldReturn and textFieldShouldEndEditing / textFieldDidEndEditing methods below to allow the enter / return / go button to have the same behavior as pressing the magnifying glass icon as well as prompt for user input or clear the text field upon entry.
         */
        searchTextField.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        let userLocationText = searchTextField.text ?? "Nothing entered"
        print("User entered: \(userLocationText)")
        searchTextField.endEditing(true)
    }
    
    @IBAction func toggleChanged (_ sender: UISwitch) {
        let unitsImperial = unitsToggle.isOn
        let unitsMetric = !unitsToggle.isOn
        print(unitsImperial)
        print(unitsMetric)
    }
    /**
     - Note: This delegate method with allow the Return key to have the same behavior as the search button
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        textField.endEditing(true)
        return true
    }
    
    /**
     - Note: This delegate method will remind our user to type something and not allow the Return key or search button to try to return what is in the text field
     */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "You need to type something..."
            return false
        }
    }

    /**
     - Note: This delegate method clears the text field upon press of the search button or Ruturn key
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        print(weather)
        print("Temp as a string is \(weather.tempString)")
    }
}
