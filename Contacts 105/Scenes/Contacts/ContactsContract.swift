//
//  ContactsContract.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

protocol ContactsDisplayable: class {
    func display(alert: UIAlertController)
}

protocol ContactsPresentable {
    var dataSource: [ContactDataStructure]? { get }
}

protocol ContactsModelable {
    func readContacts() -> [ContactDataStructure]?
}
