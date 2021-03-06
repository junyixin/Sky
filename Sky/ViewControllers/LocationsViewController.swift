//
//  LocationsViewController.swift
//  Sky
//
//  Created by junyixin on 2018/5/29.
//  Copyright © 2018 junyixin. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationsViewControllerDelete {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation)
}

class LocationsViewController: UITableViewController {
    
    var currentLocation: CLLocation?
    var favourites = UserDefaults.loadLocations()
    var delegate: LocationsViewControllerDelete?
    
    private var hasFavourites: Bool {
        return favourites.count > 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LocationsViewController {
    private enum Section: Int {
        case current
        case favourite
        
        var title: String {
            switch self {
            case .current:
                return "Current Location"
            default:
                return "Favourite Locations"
            }
        }
        
        static var count: Int {
            return Section.favourite.rawValue + 1
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexcepted section")
        }
        
        switch section {
        case .current:
            return 1
        case .favourite:
            return max(favourites.count, 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexcepted section")
        }
        
        return section.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexcepted sestion")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unexcepted table view cell")
        }
        
        var vm: LocationViewModel?
        
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                vm = LocationViewModel(location: currentLocation, locationText: nil)
            } else {
                cell.label.text = "Current location unknown"
            }
            
        case .favourite:
            if favourites.count > 0 {
                let fav = favourites[indexPath.row]
                vm = LocationViewModel(location: fav.location, locationText: nil)
            } else {
                cell.label.text = "No favourities yet..."
            }
        }
        
        if let vm = vm {
            cell.configure(with: vm)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexcepted section")
        }
        
        switch section {
        case .current:
            return false
        case .favourite:
            return hasFavourites
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let location = favourites[indexPath.row]
        UserDefaults.removeLocation(location)
        
        favourites.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.row) else {
            fatalError("Unexcepted section")
        }
        
        var location: CLLocation?
        
        switch section {
        case .current:
            if let currentLocation = currentLocation {
                location = currentLocation
            }
        case .favourite:
            if hasFavourites {
                location = favourites[indexPath.row].location
            }
        }
        
        if location != nil {
            delegate?.controller(self, didSelectLocation: location!)
            dismiss(animated: true)
        }
    }
}










