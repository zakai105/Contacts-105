//
//  ContactsModel.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation
//import Contacts

struct ContactsModel: ContactsModelable {
    
    private let contactsService: ContactsService

    init() {
        contactsService = ContactsService()
    }
    
    func readContacts() -> [ContactsDataStructure]? {
        return contactsService.readContacts()?.map({ ContactsDataStructure(cNContact: $0) })
    }
}
