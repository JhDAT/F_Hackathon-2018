//
//  WeatherData.swift
//  
//
//  Created by Jo JANGHUI on 2018. 7. 20..
//

import Foundation

struct OpenWeatherMap: Decodable {
    let base : String
    let name : String
    let temp : Double
    let tempMin : Double
    let tempMax : Double
    
    enum CodingKeys: String, CodingKey {
        case base, name, main
    }
    
    enum mainInfoKey: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        base = try value.decode(String.self, forKey: .base)
        name = try value.decode(String.self, forKey: .name)
        
        let mainInfo = try value.nestedContainer(keyedBy: mainInfoKey.self, forKey: .main)
        temp = try mainInfo.decode(Double.self, forKey: .temp)
        tempMin = try mainInfo.decode(Double.self, forKey: .tempMin)
        tempMax = try mainInfo.decode(Double.self, forKey: .tempMax)
    }
    
}
