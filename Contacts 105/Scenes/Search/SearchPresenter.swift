//
//  SearchPresenter.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/28/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

struct TrafficLightPresenter {
    
    private weak var viewDelegate: TrafficLightViewDelegate?
    private let trafficLightService: TrafficLightService
    
    init(viewDelegate: TrafficLightViewDelegate, trafficLightService: TrafficLightService) {
        self.viewDelegate = viewDelegate
        self.trafficLightService = trafficLightService
    }
    
    func trafficLightColorSelected(colorName:(String)){
        
        trafficLightService.getTrafficLight(colorName: colorName) {
            
            guard let traficLight = $0 else {
                // TODO: handle errors
                return
            }
            
            self.viewDelegate?.displayTrafficLight(description: traficLight.description)
        }
    }
}
