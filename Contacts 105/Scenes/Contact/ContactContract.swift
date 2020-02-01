//
//  ContactContract.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

protocol ContactDisplayable: class {
    func display(contact: ContactsDataStructure)
}

protocol ContactPresentable {
    var dataSource: ContactsDataStructure? { get }
}

protocol ContactModelable {
    func readContact() -> ContactsDataStructure?
}
