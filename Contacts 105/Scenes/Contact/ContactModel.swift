//
//  ContactModel.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

struct ContactModel: ContactModelable {
    
    private let contactsService: ContactsService

    init() {
        contactsService = ContactsService()
    }
    
    func readContact() -> ContactsDataStructure? {
        return contactsService.readContacts()?.map({ ContactsDataStructure(cNContact: $0) }).first
    }
}
