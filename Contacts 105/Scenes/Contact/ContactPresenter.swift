//
//  ContactPresenter.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

struct ContactPresenter: ContactPresentable {
    
    private weak var viewController: ContactDisplayable?
    private let model: ContactModelable
    var dataSource: ContactDataStructure?

    init(viewController: ContactDisplayable, identifier: String?) {
        self.viewController = viewController
        model = ContactModel()
        
        if let identifier = identifier {
            dataSource = model.readContact(withIdentifier: identifier)
        }
    }
    
    func didAdd(contact: NewContactDataStructure) {
        if let error = model.createContact(with: contact) {
            // TODO: Alert
            return
        }
    }
}

