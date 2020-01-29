//
//  ContactsService.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/28/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

struct TrafficLightService {
    
    func getTrafficLight(colorName:(String), callBack:(TrafficLight?) -> Void) {
        
        let trafficLights = [
            TrafficLight(colorName: "Red", description: "Stop"),
            TrafficLight(colorName: "Green", description: "Go"),
            TrafficLight(colorName: "Yellow", description: "About to change to red")
        ]
        
        guard let foundTrafficLight = trafficLights.first(where: { $0.colorName == colorName }) else {
            callBack(nil)
            return
        }
            
        callBack(foundTrafficLight)
    }
}
