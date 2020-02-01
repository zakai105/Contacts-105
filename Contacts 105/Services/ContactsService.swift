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
    
    func createContact(with cNMutableContact: CNMutableContact) -> Error? {
        
        let request = CNSaveRequest()
        request.add(cNMutableContact, toContainerWithIdentifier: nil)
        
        do {
            try store.execute(request)
            return nil
            
        } catch {
            return error
        }
    }
    
    func readContacts(withIdentifiers identifiers: [String]? = nil) -> [CNContact]? {
        guard let keyDescriptors = keysToFetch else { return nil }
        
        guard let identifiers = identifiers else {
            return cNContainers?
                .compactMap({ self.cNContacts(fromCNContainer: $0, keysToFetch: keyDescriptors) })
                .flatMap({ $0 })
        }
        
        return cNContainers?
            .compactMap({ self.cNContacts(fromCNContainer: $0, keysToFetch: keyDescriptors, identifiers: identifiers) })
            .flatMap({ $0 })
    }
    
    func updateContact(with cNMutableContact: CNMutableContact) -> Error? {
        guard let contactToUpdate = readContacts(withIdentifiers: [cNMutableContact.identifier])?.first?.mutableCopy() as? CNMutableContact else { return nil }
        
        contactToUpdate.imageData = cNMutableContact.imageData
        contactToUpdate.phoneNumbers = cNMutableContact.phoneNumbers
        contactToUpdate.emailAddresses = cNMutableContact.emailAddresses
        
        let request = CNSaveRequest()
        request.update(contactToUpdate)
        
        do {
            try store.execute(request)
            return nil
            
        } catch {
            return error
        }
    }
    
    func deleteContact(withIdentifier identifier: String) -> Error? {
        guard let contactToDelete = readContacts(withIdentifiers: [identifier])?.first?.mutableCopy() as? CNMutableContact else { return nil }
        
        let request = CNSaveRequest()
        request.delete(contactToDelete)
        
        do {
            try store.execute(request)
            return nil
            
        } catch {
            return error
        }
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
    
    var keysToFetch: [CNKeyDescriptor]? {
        let cNKeyDescriptors: [Any] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey
        ]
        
        return cNKeyDescriptors as? [CNKeyDescriptor]
    }
    
    func cNContacts(fromCNContainer cNContainer: CNContainer, keysToFetch: [CNKeyDescriptor]) -> [CNContact]? {
        
        let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: cNContainer.identifier)
        
        do {
            return try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch)
        } catch {
            print(error.usefulDescription)
            return nil
        }
    }
    
    func cNContacts(fromCNContainer cNContainer: CNContainer, keysToFetch: [CNKeyDescriptor], identifiers: [String]) -> [CNContact]? {
        
        let fetchPredicate = CNContact.predicateForContacts(withIdentifiers: identifiers)
        
        do {
            return try store.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch)
        } catch {
            print(error.usefulDescription)
            return nil
        }
    }
}
