//
//  WeatherObject.swift
//  Weather(IOS)
//
//  Created by Simon Wilson on 16/03/2022.
//

import Foundation

struct WeatherObject {
    
    
    var temp: Double
    var description: String
    var hiTemp: Double
    var lowTemp: Double
    var humidity: Int
    var cloudCover: Int
    var windSpeed: Double
    var visibility: Int
    var pressure: Int
    var timeStamp: Int
    var chanceOfRain: Double
    
    init(description: String, temp: Double, hiTemp: Double, lowTemp: Double,
         humidity: Int, cloudCover:  Int, windSpeed: Double, visibility: Int, pressure: Int, timeStamp: Int, chanceOfRain: Double) {
    
        self.temp = temp
        self.description = description
        self.hiTemp = hiTemp
        self.lowTemp = lowTemp
        self.humidity = humidity
        self.cloudCover = cloudCover
        self.windSpeed = windSpeed
        self.visibility = visibility
        self.pressure = pressure
        self.timeStamp = timeStamp
        self.chanceOfRain = chanceOfRain
    
}
    
}
