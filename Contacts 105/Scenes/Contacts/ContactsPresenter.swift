//
//  ContactsPresenter.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation

struct ContactsPresenter {
    
    private let viewDelegate: ContactsViewDelegate?
    private let contactsService: ContactsService

    init(viewDelegate: ContactsViewDelegate, contactsService: ContactsService) {
        self.viewDelegate = viewDelegate
        self.contactsService = contactsService
    }

    func didLoad() {

        contactsService.RetrieveContacts(callBack: {
            
            guard let cNContacts = $0 else {
                // TODO: Alert "you have no contacts"
                return
            }
            
            let contacts = cNContacts.map({ Contact(cNContact: $0) })
            self.viewDelegate?.display(contacts: contacts)
        })
    }
}
