//
//  ViewController.swift
//  Clima
//
//  Created by Rob Ranf on 12/2/2020.
//  Copyright © 2020 Emiya Consulting. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // We are setting the current ViewController as the delegate for our searchTextField outlet. This allows our searchTextField to communicate with the entire view controller (it can be notified and respond to changes in the vc such as keyboard presses)...this allows us to use our textFieldShouldReturn method below to allow the enter / return / go button to have the same behavior as pressing the magnifying glass icon
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        let userLocationText = searchTextField.text ?? "Nothing entered"
        print(userLocationText)
        searchTextField.endEditing(true)
    }
    /** This delegate method with allow the Return key to have the same behavior as the search button */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        textField.endEditing(true)
        return true
    }
    
    /** This delegate method will remind our user to type something and not allow the Return key or search button to try to return what is in the text field */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "You need to type something..."
            return false
        }
    }

    /** This delegate method clears the text field upon press of the search button or Ruturn key */
    // FIXME: This code is not being executed now because of the textShouldEndEditing method
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
