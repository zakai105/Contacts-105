//
//  ContactContract.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

protocol ContactDisplayable: class {
    func display(contact: ContactDataStructure)
    func dismiss()
}

protocol ContactPresentable {
    var dataSource: ContactDataStructure? { get }
    func didAdd(contact: NewContactDataStructure)
}

protocol ContactModelable {
    func readContact(withIdentifier identifier: String) -> ContactDataStructure?
    func createContact(with contact: NewContactDataStructure) -> Error?
}
