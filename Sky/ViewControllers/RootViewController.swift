//
//  ViewController.swift
//  Sky
//
//  Created by junyixin on 17/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    private var segueCurrentWeather = "SegueCurrentWeather"
    private var segueWeekWeather = "SegueWeekWeather"
    private var segueSetting = "SegueSetting"
    private var segueLocations = "SegueLocations"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller.")
            }
            
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
        case segueWeekWeather:
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("Invalid destination view controller.")
            }
            
            weekWeatherViewController = destination
        case segueSetting:
            guard let nav = segue.destination as? UINavigationController else {
                fatalError("Invalid destination view controller.")
            }
            
            guard let destination = nav.topViewController as? SettingTableViewController else {
                fatalError("Invalid destination view controller.")
            }
            
            destination.delegate = self
        case segueLocations:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("Invalid destination view controller")
            }
            
            guard let destination = navigationController.topViewController as? LocationsViewController else {
                fatalError("Invalid destination view controller")
            }
            
            destination.delegate = self
            destination.currentLocation = currentLocation
        default:
            break
        }
    }
    
    @IBAction func backToRootViewController(segue: UIStoryboardSegue) {
        //
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    
    private var currentLocation: CLLocation? {
        didSet {
            fetchCity()
            fetchWeather()
        }
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks, error) in
            if let error = error {
                dump(error)
            }
            else if let city = placemarks?.first?.locality {
                let loc = Location(name: city, latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                
                self.currentWeatherViewController.viewModel?.location = loc
            }
        })
    }
    
    private func fetchWeather() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon) { (response, error) in
            if let error = error {
                dump(error)
            }
            else if let response = response {
                self.currentWeatherViewController.viewModel?.weather = response
                self.weekWeatherViewController.viewModel = WeekWeatherViewModel(response.daily.data)
            }
        }
    }
    
    private func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActiveNotification()
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(RootViewController.applicationDidBecomeActive(notification:)),
                                               name: Notification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         dump(error)
    }
}


extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        performSegue(withIdentifier: segueLocations, sender: self)
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        performSegue(withIdentifier: segueSetting, sender: self)
    }
}

extension RootViewController: SettingTableViewControllerDelegate {
    private func reloadUI() {
        currentWeatherViewController.updateView()
        weekWeatherViewController.updateView()
    }
    
    func controllerDidChangeTimeMode(controller: SettingTableViewController) {
        reloadUI()
    }
    
    func controllerDidChangeTemperatureMode(controller: SettingTableViewController) {
        reloadUI()
    }
}

extension RootViewController: LocationsViewControllerDelete {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation) {
        currentLocation = location
    }
}




