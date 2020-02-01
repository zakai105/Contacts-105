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
    var dataSource: ContactsDataStructure?

    init(viewController: ContactDisplayable) {
        self.viewController = viewController
        model = ContactModel()
        dataSource = model.readContact()
    }
}
