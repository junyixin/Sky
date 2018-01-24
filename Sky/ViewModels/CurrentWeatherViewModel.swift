//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by junyixin on 24/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    var isLocationReady = false
    var isWeatherReady = false
    
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
    
    var location: Location! {
        didSet {
            if location != nil {
                isLocationReady = true
            }
            else {
                isLocationReady = false
            }
        }
    }
    
    var weather: WeatherData! {
        didSet {
            if weather != nil {
                isWeatherReady = true
            }
            else {
                isWeatherReady = false
            }
        }
    }
    
    var weatherIcon: UIImage {
        return UIImage.weatherIcon(of: weather.currently.icon)!
    }
    
    var city: String {
        return location.name
    }
    
    var temperature: String {
        return String(format: "%.1f ℃", weather.currently.temperature)
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity * 100)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, dd MMMM"
        
        return dateFormatter.string(from: weather.currently.time)
    }
}
