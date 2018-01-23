//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by junyixin on 23/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: CurrentWeatherViewController)
    func settingsButtonPressed(controller: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    var now: WeatherData? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var location: Location? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let now = now, let location = location {
            updateWeatherContainerView(with: now, at: location)
        }
        else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Fetch weather/location failed."
        }
    }
    
    func updateWeatherContainerView(with data: WeatherData, at location: Location) {
        weatherContainerView.isHidden = false
        
        locationLabel.text = location.name
        temperatureLabel.text = String(
            format: "%.1f",
            data.currently.temperature.toCelcius())
        
        weatherIcon.image = weatherIcon(of: data.currently.icon)
        humidityLabel.text = String(format: "%.1f", data.currently.humidity)
        summaryLabel.text = data.currently.summary
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        dateLabel.text = formatter.string(from: data.currently.time)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //
    }
    
    @IBAction func locationBtnClicked(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingBtnClicked(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }
}
