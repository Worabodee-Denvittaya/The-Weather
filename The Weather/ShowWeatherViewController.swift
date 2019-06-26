//
//  ShowWeatherViewController.swift
//  The Weather
//
//  Created by Worabodee Denvittaya on 6/26/19.
//  Copyright © 2019 Worabodee Denvittaya. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ShowWeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "2fbb29acd9ab18bd5ad6e79c159eb187"
    let locationManager = CLLocationManager()
    let weather = Weather()
    
    //IBOutlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherCondition: UIImageView!
    @IBOutlet weak var changeCityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityNameLabel.text = "Connection Issues"
            }
        }
    } //getWeatherData
    
    
    func updateWeatherData(json : JSON) {
        
        let tempResult = json["main"]["temp"].doubleValue
        
        weather.temperature = Int(tempResult - 273.15)
        
        weather.city = json["name"].stringValue
        
        weather.condition = json["weather"][0]["id"].intValue
        
        weather.weatherIconName = weather.getIcon(condition: weather.condition)
        
        updateUIWithWeatherData()
    } //updateWeatherData
    
    
    func updateUIWithWeatherData() {
        
        cityNameLabel.text = weather.city
        temperatureLabel.text = "\(weather.temperature)°"
        weatherCondition.image = UIImage(named: weather.weatherIconName)
        
    }
    
    //delegate method
    func newCityNameEntered(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    } //userEnteredANewCityName
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            
            destinationVC.delegate = self
            
        }
    } //prepare for segue method
}

