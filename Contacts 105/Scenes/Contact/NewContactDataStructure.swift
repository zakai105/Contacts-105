//
//  NewContactDataStructure.swift
//  Contacts 105
//
//  Created by Roi Zakai on 2/1/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit
import Contacts

struct NewContactDataStructure {
    
    let name: String?
    let avatar: UIImage?
    let phoneNumbers: [String?]?
    let emailAddresses: [String?]?
    
    var cNMutableContact: CNMutableContact {
        
        let contact = CNMutableContact()
        
        if let name = name {
            contact.givenName = name
        }
        
        if let phoneNumbers = phoneNumbers?.compactMap({ $0 }) {
            contact.phoneNumbers = phoneNumbers.map({ CNLabeledValue(label: CNLabelWork, value: CNPhoneNumber(stringValue: $0)) })
        }
        
        if let emailAddresses = emailAddresses?.compactMap({ $0 }) {
            contact.emailAddresses = emailAddresses.map({ CNLabeledValue(label: CNLabelWork, value: $0 as NSString) })
        }
                
        return contact
    }
}
