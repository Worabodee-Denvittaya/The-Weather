//
//  ChangeCityViewController.swift
//  The Weather
//
//  Created by Worabodee Denvittaya on 6/26/19.
//  Copyright © 2019 Worabodee Denvittaya. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeCityDelegate {
    func newCityNameEntered(city : String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    //Show Weather button
    @IBAction func showWeatherPressed(_ sender: Any) {
        let cityName = cityNameTextField.text!
        
        delegate?.newCityNameEntered(city: cityName)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //back button
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
