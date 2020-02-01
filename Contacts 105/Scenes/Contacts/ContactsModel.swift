//
//  ContactsModel.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

struct ContactsModel: ContactsModelable {
    
    private let contactsService: ContactsService

    init() {
        contactsService = ContactsService()
    }
    
    func readContacts() -> [ContactDataStructure]? {
        return contactsService.readContacts()?
            .map({ ContactDataStructure(cNContact: $0, namePlaceHolder: "Name", phonePlaceHolder: "Phone number", mailPlaceHolder: "Email Addresse") })
    }
}
