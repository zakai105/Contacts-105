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
        cell.selectionStyle = .none
        cell.imageView?.image = presenter?.dataSource?[indexPath.row].avatar
        cell.textLabel?.text = presenter?.dataSource?[indexPath.row].name
        return cell
    }
}

// MARK: - Table view delegate

extension ContactsViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = presenter?.dataSource?[indexPath.row]
        let cvc = ContactViewController()
        navigationController?.pushViewController(cvc, animated: true)
    }
}
