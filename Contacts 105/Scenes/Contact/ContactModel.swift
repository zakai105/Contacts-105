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
    
    func createContact(with contact: RawContactDataStructure) -> Error? {
        return contactsService.createContact(with: contact.cNMutableContact)
    }
    
    func readContact(withIdentifier identifier: String) -> ContactDataStructure? {
        guard let contact = contactsService.readContacts(withIdentifiers: [identifier])?.first else { return nil }
        return ContactDataStructure(cNContact: contact, namePlaceHolder: "Name", phonePlaceHolder: "Phone number", mailPlaceHolder: "Email Addresse")
    }
    
    func updateContact(with contact: RawContactDataStructure) -> Error? {
        return contactsService.updateContact(with: contact.cNMutableContact)
    }
    
    func deleteContact(withIdentifier identifier: String) -> Error? {
        return contactsService.deleteContact(withIdentifier: identifier)
    }
}
