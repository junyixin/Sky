//
//  ViewController.swift
//  Sky
//
//  Created by junyixin on 17/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherDataManager.shared.weatherDataAt(latitude: 37.8267, longitude: -122.4233) {
            (data, error) in
            
            if let error = error {
                print("error: \(error)")
            }
            else {
                print("data: \(data!)")
            }
        }
    }
}

