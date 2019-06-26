//
//  File.swift
//  The Weather
//
//  Created by Worabodee Denvittaya on 6/26/19.
//  Copyright © 2019 Worabodee Denvittaya. All rights reserved.
//

import Foundation
import UIKit

class Weather {
    
    //weather properties
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //switch to turn the returned condition into the image name
    func getIcon(condition: Int) -> String {

        switch (condition) {

        case 0...300 :
        return "storm"

        case 301...500 :
        return "rain"

        case 501...600 :
        return "rain"

        case 601...700 :
        return "snow"

        case 701...771 :
        return "cloudy"

        case 772...799 :
        return "heavy_storm"

        case 800 :
        return "sunny"

        case 801...804 :
        return "cloudy"

        case 900...903, 905...1000  :
        return "heavy_storm"

        case 903 :
        return "snow"

        case 904 :
        return "sunny"

        default :
        return "sunny"
        }
    }
}
