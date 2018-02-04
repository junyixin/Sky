//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by junyixin on 29/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {
    
    var viewModel: WeekWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }

    @IBOutlet weak var weekWeatherTableView: UITableView!
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let _ = viewModel {
            updateContainerView()
        }
        else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "fetch weather/location failed."
        }
    }
    
    func updateContainerView() {
        weatherContainerView.isHidden = false
        weekWeatherTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
    }
}

extension WeekWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let _ = viewModel else {
            return 0.0
        }
        
        return 104.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let vm = viewModel else {
            return 0
        }
        
        return vm.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else {
            return 0
        }
        
        return vm.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.identifier, for: indexPath) as? WeekWeatherTableViewCell
        
        guard let row = cell else {
            fatalError("Unexpected table view cell.")
        }
        
        if let vm = viewModel {
            row.week.text = vm.week(for: indexPath.row)
            row.date.text = vm.date(for: indexPath.row)
            row.temp.text = vm.temperature(for: indexPath.row)
            row.weatherIcon.image = vm.weatherIcon(for: indexPath.row)
            row.humid.text = vm.humidity(for: indexPath.row)
        }
        
        return row
    }
}
