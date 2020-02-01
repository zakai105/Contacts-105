//
//  ContactsService.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import Foundation
import Contacts

struct ContactsService {
    
    private let store = CNContactStore()
    
    func readContacts() -> [CNContact]? {
        guard let keyDescriptors = cNKeyDescriptors else { return nil }
                
        var results = [CNContact]()
        
        cNContainers?.forEach {
            
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: $0.identifier)
            
            do {
                let containerResults = try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keyDescriptors)
                results.append(contentsOf: containerResults)
            } catch {
                print(error.usefulDescription)
            }
        }

        return results
    }
}

// MARK: - Helpers

private extension ContactsService {
    
    var cNContainers: [CNContainer]? {
        
        do {
            return try store.containers(matching: nil)
        } catch {
            print(error.usefulDescription)
            return nil
        }
    }
    
    var cNKeyDescriptors: [CNKeyDescriptor]? {
        let keysToFetch: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey
        ]
        
        return keysToFetch as? [CNKeyDescriptor]
    }
}

extension Error {
    
    var usefulDescription: String {
        let nSError = self as NSError
        return "\(nSError), \(nSError.userInfo)"
    }
}
