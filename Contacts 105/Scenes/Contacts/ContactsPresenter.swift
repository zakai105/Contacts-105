//
//  ContactsPresenter.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

struct ContactsPresenter: ContactsPresentable {
    
    private weak var viewController: ContactsDisplayable?
    private let model: ContactsModelable
    var dataSource: [ContactDataStructure]?

    init(viewController: ContactsDisplayable) {
        self.viewController = viewController
        model = ContactsModel()
        dataSource = model.readContacts()?.sorted(by: { $0.name?.lowercased() ?? "" < $1.name?.lowercased() ?? "" })
    }
}
