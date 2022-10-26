//
//  ParseJsonDataStruct.swift
//  Weather(IOS)
//
//  Created by Simon Wilson on 19/04/2022.
//

import Foundation

struct ParseJsonData {
    
    var weatherDataArray = [WeatherObject]()
    
    mutating func parse(jsonData: [String : Any]) -> [WeatherObject] {
        
        weatherDataArray.removeAll(keepingCapacity: false)
        
        if let weatherArray = jsonData["list"] as? [Any] {
            
            for weather in weatherArray {
                
                if let weatherData = weather as? [String : Any] {
                    
                    if let data = weatherData["main"] as? [String : Any] {
                        
                        if let temp = data["temp"] as? Double {
                            
                            if let hitemp = data["temp_max"] as? Double {
                                
                                if let lowTemp = data["temp_min"] as? Double {
                                    
                                    if let pressure = data["pressure"] as? Int {
                                        
                                        if let humidity = data["humidity"] as? Int {
                                            
                                            if let descriptionData = weatherData["weather"] as? [Any] {
                                                
                                                if let descriptionObj = descriptionData[0] as? [String : Any] {
                                                    
                                                    if let desc = descriptionObj["description"] as? String {
                                                        
                                                        if let cloudCoverdata = weatherData["clouds"] as? [String : Any] {
                                                            
                                                            if let cloudCover = cloudCoverdata["all"] as? Int {
                                                                
                                                                if let windSpeedData = weatherData["wind"] as? [String : Any] {
                                                                    
                                                                    if let windSpeed = windSpeedData["speed"] as? Double {
                                                                        
                                                                        if let time = weatherData["dt"]  as? Int {
                                                                            
                                                                            if let visibility = weatherData["visibility"] as? Int {
                                                                                
                                                                                if let chanceOfRain = weatherData["pop"] as? Double {
                                                                                
                                                                                    let weather = WeatherObject(description: desc, temp: temp, hiTemp: hitemp, lowTemp: lowTemp, humidity: humidity, cloudCover: cloudCover, windSpeed: windSpeed, visibility: visibility, pressure: pressure, timeStamp: time, chanceOfRain: chanceOfRain)
                                                                                
                                                                                self.weatherDataArray.append(weather)
                                                                                    
                                                                                }
                                                                            }
                                                                            
                                                                            
                                                                            
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
        return weatherDataArray
        
    }
        
}
    

