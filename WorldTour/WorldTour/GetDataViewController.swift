//
//  GetDataViewController.swift
//  WorldTour
//
//  Created by Jo JANGHUI on 2018. 7. 20..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class GetDataViewController: UIViewController {
    
    let kelvin: Double = 273.15
    var cityname : [String : [Double]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city = CityName.location.self
        let seoul = [city.seoul]
        //        let cityArr: [CityName.location] = [.sapporo, .tokyo, .sydney, .hawaii, .vladivostok,
        //                   .zagreb, .bangkok, .london, .yellowknife, .paris, .taipei,
        //                   .dubai, .roma, .madrid, .okinawa, .swis, .cairns, .uluru,
        //                   .uluru, .newYork, .alaska, .boracay, .maldives, .kotaKinabalu,
        //                   .bali, .malta, .hoiAn, .hongKong, .iceland, .mongolia, .greece]
        let cityArr: [CityName.location] = [.sapporo]
        apiload(city: seoul)
        apiload(city: cityArr)
    }
    
    func apiload(city: [CityName.location]) {
        for idx in 0..<city.count {
            let cityStringName = city[idx].rawValue
            let position = "https://api.openweathermap.org/data/2.5/weather?q=\(cityStringName)&appid=23993687fb69bfa2e960340ec8d72b27"
            let apiURL = URL(string: position)!
            
            let dataTask = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
                guard error == nil else { return print("error")}
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    print("status error")
                    return
                }
                
                guard let data = data else { return print("Parsing error")}
                let jsonObject = try? JSONDecoder().decode(OpenWeatherMap.self, from: data)
                
                guard let name = jsonObject?.name,
                    let currentTemp = jsonObject?.temp,
                    let maxTemp = jsonObject?.tempMax,
                    let minTemp = jsonObject?.tempMin,
                    let humidity = jsonObject?.humidity,
                    let lon = jsonObject?.lon,
                    let lat = jsonObject?.lat
                    else { return print("parsing error")}
                
                let currentKelbinToTemp = ceil(currentTemp - self.kelvin)
                let maxKelbinToTemp = ceil(maxTemp - self.kelvin)
                let minKelbinToTemp = ceil(minTemp - self.kelvin)
                
                self.cityname = [
                    name : [
                        currentKelbinToTemp,
                            maxKelbinToTemp,
                            minKelbinToTemp,
                            ceil(humidity),
                            lon,
                            lat
                    ]
                ]
                print(self.cityname)
            }
            dataTask.resume()
        }
    }
    
}
