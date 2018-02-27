//
//  WeakWeatherTableViewCell.swift
//  Sky
//
//  Created by junyixin on 29/01/2018.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    
    static let identifier = "WeekWeatherCell"
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with vm: WeekWeatherDayRepresentable) {
        week.text = vm.week
        date.text = vm.date
        temp.text = vm.temperature
        humid.text = vm.humidity
        weatherIcon.image = vm.weatherIcon
    }
}
