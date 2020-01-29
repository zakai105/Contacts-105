//
//  SearchViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/27/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

protocol TrafficLightViewDelegate: NSObjectProtocol {
    func displayTrafficLight(description:(String))
}

class SearchViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    private lazy var trafficLightPresenter = TrafficLightPresenter(
        viewDelegate: self,
        trafficLightService: TrafficLightService()
    )
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    @IBAction func redLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Red")
    }
    
    @IBAction func yellowLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Yellow")
    }
    
    @IBAction func greenLightAction(_ sender: Any) {
        trafficLightPresenter.trafficLightColorSelected(colorName:"Green")
    }
}

extension SearchViewController: TrafficLightViewDelegate {
    
    func displayTrafficLight(description:(String)) {
        descriptionLabel.text = description
    }
}
