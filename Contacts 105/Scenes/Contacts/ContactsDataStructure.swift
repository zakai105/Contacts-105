//
//  ContactsDataStructure.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit
import Contacts

struct ContactsDataStructure {
    
    let name: String?
    let avatar: UIImage?
    let phoneNumbers: [String]?
    let emailAddresses: [String]?
    let isSelected: Bool = false
    let isInvited = false
    
    init(cNContact: CNContact) {
        name = cNContact.givenName + " " + cNContact.familyName
        avatar = UIImage(data: cNContact.thumbnailImageData)
        phoneNumbers = cNContact.phoneNumbers.map({ $0.value.stringValue })
        emailAddresses = cNContact.emailAddresses.map({ $0.value as String })
    }
}
