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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let city = CityName.location.self
        let seoul = city.seoul
//        let cityArr: [CityName.location] = [.sapporo, .tokyo, .sydney, .hawaii, .vladivostok,
//                   .zagreb, .bangkok, .london, .yellowknife, .paris, .taipei,
//                   .dubai, .roma, .madrid, .okinawa, .swis, .cairns, .uluru,
//                   .uluru, .newYork, .alaska, .boracay, .maldives, .kotaKinabalu,
//                   .bali, .malta, .hoiAn, .hongKong, .iceland, .mongolia, .greece]
        let cityArr: [CityName.location] = [.sapporo]
        var cityname : [String : [Double]]!
        
        for idx in 0..<cityArr.count {
            let cityStringName: String = cityArr[idx].rawValue as! String
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
                let name = jsonObject?.name as! String
                let currentTemp = jsonObject?.temp as! Double
                let maxTemp = jsonObject?.tempMax as! Double
                let minTemp = jsonObject?.tempMin as! Double
                let humidity = jsonObject?.humidity as! Double

//                ceil(currentTemp)
//                ceil(maxTemp)
//                ceil(minTemp)
//                ceil(humidity)
                
                let currentKelbinToTemp = ceil(currentTemp - self.kelvin)
                let maxKelbinToTemp = ceil(maxTemp - self.kelvin)
                let minKelbinToTemp = ceil(minTemp - self.kelvin)
                
                cityname = [name : [currentKelbinToTemp, maxKelbinToTemp, minKelbinToTemp, ceil(humidity)]]
                print(cityname)
            }
            dataTask.resume()
        }
        
        //            print(jsonObject?.name)
        //            print(jsonObject?.humidity)
        //            print(jsonObject?.temp)
        //            print(jsonObject?.tempMax)
        //            print(jsonObject?.tempMin)
        //            let currentTemp = (jsonObject?.temp)! - self.kelvin
        //            print(currentTemp)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
