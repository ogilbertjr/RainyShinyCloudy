//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Osie G on 11/21/16.
//  Copyright © 2016 Osie G. All rights reserved.
//

import UIKit
import CoreLocation //accesses device's current location
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeather = CurrentWeather()
        
        tableView.dataSource = self
        tableView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        print(currentURL)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    //delegate functions
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            //print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //just one section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //how many cells in table view
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell so it knows what to recreate in our table view under reusable table cell identifier
        
        //looks for tableview identifier of weatherCell
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
        
        //recycles cells already on screen moves data to next cell
        
    }

    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather._currentTemp)"
        currentWeatherTypeLabel.text = currentWeather._weatherType
        locationLabel.text = currentWeather._cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        let dailyForecastURL = URL(string: forecastURL)!
        Alamofire.request(dailyForecastURL).responseJSON{ response in
        
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    


}

