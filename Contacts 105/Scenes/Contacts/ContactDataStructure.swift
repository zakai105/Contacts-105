//
//  ContactDataStructure.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit
import Contacts

struct ContactDataStructure {
    
    let identifier: String
    let name: String?
    let avatar: UIImage?
    let phoneNumbers: [String]?
    let emailAddresses: [String]?
    let namePlaceHolder: String?
    let phonePlaceHolder: String?
    let mailPlaceHolder: String?
    
    init(cNContact: CNContact, namePlaceHolder: String?, phonePlaceHolder: String?, mailPlaceHolder: String?) {
        identifier = cNContact.identifier
        name = cNContact.givenName + " " + cNContact.familyName
        avatar = UIImage(data: cNContact.thumbnailImageData)
        phoneNumbers = cNContact.phoneNumbers.map({ $0.value.stringValue })
        emailAddresses = cNContact.emailAddresses.map({ $0.value as String })
        self.namePlaceHolder = namePlaceHolder
        self.phonePlaceHolder = phonePlaceHolder
        self.mailPlaceHolder = mailPlaceHolder
    }
}
