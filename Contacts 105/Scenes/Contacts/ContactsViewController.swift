//
//  ContactsViewController.swift
//  Contacts 105
//
//  Created by Roi Zakai on 1/31/20.
//  Copyright © 2020 Roi Zakai. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController {
        
    private var presenter: ContactsPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = ContactsPresenter(viewController: self)
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.reloadData()
    }
}

// MARK: - Contacts displayable

extension ContactsViewController: ContactsDisplayable {
    
    func display(contacts: [ContactDataStructure]) {
        
        // TODO: - do somthing...
    }
}

// MARK: - Table view data source

extension ContactsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return presenter?.dataSource?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .blue
            cell.textLabel?.text = "Add new contact"
            cell.imageView?.image = nil
        } else {
            cell.textLabel?.textAlignment = .natural
            cell.textLabel?.text = presenter?.dataSource?[indexPath.row].name
            cell.imageView?.image = presenter?.dataSource?[indexPath.row].avatar
        }
        
        return cell
    }
}

// MARK: - Table view delegate

extension ContactsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cvc = UIStoryboard(name: "Contact", bundle: nil).instantiateInitialViewController() as? ContactViewController else { return }
        
        if indexPath.section == 0 {
            cvc.isAdding = true
        } else {
            cvc.identifier = presenter?.dataSource?[indexPath.row].identifier
        }
        
        navigationController?.pushViewController(cvc, animated: true)
    }
}
