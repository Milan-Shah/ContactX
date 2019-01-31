//
//  ListViewController.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ListViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    var presenter: ListViewToPresenterProtocol?
    var favoriteContacts: [Contacts]?
    var otherContacts: [Contacts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.isHidden = true
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showProgressIndicator(view: self.view)
        self.navigationItem.title = "Contacts"
        presenter?.startFetchingContacts() // Will load Contacts from local realm database if exists
    }
    
}

extension ListViewController: ListPresenterToViewProtocol {
    
    func showError() {
        
        hideProgressIndicator(view: self.view)
        
        // Show error
        let errorAlert = UIAlertController(title: "Oops", message: "Something went wrong. Please see logs.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true, completion: nil)
    }
    
    func showContacts(_ favoriteContacts: [Contacts], _ otherContacts: [Contacts]) {
        
        hideProgressIndicator(view: self.view)
        self.contactsTableView.isHidden = false
        self.favoriteContacts = favoriteContacts
        self.otherContacts = otherContacts
        self.contactsTableView.reloadData()
        
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // favorites and others
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " Favorite Contacts".uppercased()
        }
        return " Other Contacts".uppercased()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let favoritesCount = favoriteContacts?.count, section == 0 {
            return favoritesCount
        }
        
        if let othersCount = otherContacts?.count, section == 1 {
            return othersCount
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! ContactsListCell
        
        cell.favoriteImageView.image = UIImage(named: String(format: "favorite-star-true"))
        cell.favoriteImageView.isHidden = true
        
        if indexPath.section == 0 {
            if let contactAtIndex = favoriteContacts?[indexPath.row] {
                cell.companyNameLabel.text = contactAtIndex.companyName
                cell.nameLabel.text = contactAtIndex.name
                if contactAtIndex.isFavorite {
                    cell.favoriteImageView.isHidden = false
                }
            }
            
        } else {
            if let contactAtIndex = otherContacts?[indexPath.row] {
                cell.companyNameLabel.text = contactAtIndex.companyName
                cell.nameLabel.text = contactAtIndex.name
            }
        }
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 { // Favortie Contacts
            if let selectedContact = favoriteContacts?[indexPath.row] {
                presenter?.showContactDetail(forContact: selectedContact)
            }
        } else { // Other Contacts
            
            if let selectedContact = otherContacts?[indexPath.row] {
                presenter?.showContactDetail(forContact: selectedContact)
            }
            
        }
    }
    
}

// MARK: - ListCryptoCell
class ContactsListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
}
