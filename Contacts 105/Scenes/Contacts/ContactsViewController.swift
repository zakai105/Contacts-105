//
//  ContactsViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit
import Contacts

protocol ContactsViewDelegate {
    func display(contacts: [Contact])
}

class ContactsViewController: UITableViewController {
    
    private var contacts: [Contact]?
    
    private lazy var presenter = ContactsPresenter(
        viewDelegate: self,
        contactsService: ContactsService()
    )
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        presenter.didLoad()
    }
        
//    func phoneNumberWithContryCode() -> [String] {
//
//        let contacts = Contacts.getContacts() // here calling the getContacts methods
//        var arrPhoneNumbers = [String]()
//        for contact in contacts {
//            for ContctNumVar: CNLabeledValue in contact.phoneNumbers {
//                if let fulMobNumVar  = ContctNumVar.value as? CNPhoneNumber {
//                    //let countryCode = fulMobNumVar.value(forKey: "countryCode") get country code
//                    if let MccNamVar = fulMobNumVar.value(forKey: "digits") as? String {
//                        arrPhoneNumbers.append(MccNamVar)
//                    }
//                }
//            }
//        }
//        return arrPhoneNumbers // here array has all contact numbers.
//    }
}

// MARK: - Contacts view delegate

extension ContactsViewController: ContactsViewDelegate {
    
    func display(contacts: [Contact]) {
        
        self.contacts = contacts
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension ContactsViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.imageView?.image = contacts?[indexPath.row].avatar
        cell.textLabel?.text = contacts?[indexPath.row].name
        return cell
    }
}
