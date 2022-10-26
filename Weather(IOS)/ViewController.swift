//
//  ViewController.swift
//  Weather(IOS)
//
//  Created by Simon Wilson on 08/03/2022.
//

import UIKit
import CoreLocation
import SwiftDate

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var loTempLabel: UILabel!
    @IBOutlet weak var hiTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var locationManager = CLLocationManager()
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    var url = ""
    
    var userDefaults = UserDefaults()
    
    var parseJsonDataStruct = ParseJsonData()
    
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let latitude = locations.first?.coordinate.latitude {
            
            if let longit = locations.first?.coordinate.longitude {
                
                url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longit)&cnt=16&units=metric&appid=5395ac65622d176519bdd00654f3331f"
                
                getWeather(url: url)
                
                getLocation(location: locations[0])
                
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updatedAtLabel.text =  "updated at: \(getDateAndTime())"
        
        if let humidity = userDefaults.string(forKey: "humidity"){
            humidityLabel.text = "Humidity: \(humidity)"
        }
       
    }
    
    
    func getWeather(url: String) {
        
        if let url = URL(string: url) {
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                } else {
                    
                    if let data = data {
                        
                        do {
                            
                            if let parsedJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                                
                                DispatchQueue.main.async {
                                    
                                    let weather = self.parseJsonDataStruct.parse(jsonData: parsedJson)
                                    
                                    let todaysWeather = weather[0]
                                    
                                    self.humidityLabel.text = "\(todaysWeather.humidity)%"
                                    self.userDefaults.set(todaysWeather.humidity, forKey: "humidity")
                                    
                                    self.tempLabel.text = "\(todaysWeather.temp)°C"
                                    
                                    self.descriptionLabel.text = todaysWeather.description
                                    
                                    self.loTempLabel.text = "\(todaysWeather.lowTemp)°C"
                                    
                                    self.hiTempLabel.text = "\(todaysWeather.hiTemp)°C"
                                    
                                    self.cloudCoverLabel.text = "\(todaysWeather.cloudCover)"
                                    
                                    self.windSpeedLabel.text = "\(todaysWeather.windSpeed)"
                                    
                                    self.visibilityLabel.text = "\(todaysWeather.visibility)"
                                    
                                }
                                
                            }
                            
                        } catch {
                            print("unable to parse json")
                        }
                        
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
        
    }
    
    func getLocation(location: CLLocation) {
        
        let myLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(myLocation) { (placemarks, error) in
            
            if let placemark = placemarks {
                
                if let city = placemark[0].locality {
                    
                    self.locationLabel.text = "\(city)"
                    //print(city)
                    
                }
                
            }
            
        }
        
    }
    
    func getDateAndTime() -> String{
        
        let date = Date()

        let formatter = DateFormatter()

        formatter.timeZone = .current

        formatter.dateFormat = "dd/MM/YYYY HH:mm"

        let result = formatter.string(from: date)

        return result
        
    }
    
}

