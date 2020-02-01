//
//  ContactsViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
    
//    private var contacts: [ContactsDataStructure]?
    
    private var presenter: ContactsPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ContactsPresenter(viewController: self)
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.reloadData()
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

// MARK: - Contacts displayable

extension ContactsViewController: ContactsDisplayable {
    
    func display(contacts: [ContactsDataStructure]) {
        
        // TODO: - do somthing...
    }
}

// MARK: - Table view data source

extension ContactsViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.imageView?.image = presenter?.dataSource?[indexPath.row].avatar
        cell.textLabel?.text = presenter?.dataSource?[indexPath.row].name
        return cell
    }
}
