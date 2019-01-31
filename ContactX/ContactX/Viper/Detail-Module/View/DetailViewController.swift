//
//  DetailViewController.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var selectedContactTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    var presenter: DetailViewToPresenterProtocol?
    var selectedContact: Contacts?
    var button: UIButton = UIButton(type: UIButton.ButtonType.custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedContactTableView.delegate = self
        self.selectedContactTableView.dataSource = self
        self.nameLabel.text = selectedContact?.name
        self.companyNameLabel.text = selectedContact?.companyName
        
        // Navigation bar button
        addFavoriteBarButtonItem()
    }
    
    func updateBarButtonImage() {
        
        button.setImage(UIImage(named: "favorite-star-false"), for: .normal)
        if let selectedContact = selectedContact, selectedContact.isFavorite {
            button.setImage(UIImage(named: "favorite-star-true"), for: .normal)
        }
    }
    
    func addFavoriteBarButtonItem() {
        
        updateBarButtonImage()
        button.addTarget(self, action: #selector(favoriteButtonClicked(sender:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    @objc func favoriteButtonClicked(sender: UIButton) {
        
        // Make the contact favorite/other
        guard let selectedContact = selectedContact else {
            return
        }
        
        self.presenter?.updateContact(selectedContact)
    }
        
}


extension DetailViewController: DetailPresenterToViewProtocol {
    
    func updatedContact(_ contact: Contacts) {
        self.selectedContact = contact
        updateBarButtonImage()
        print("Updated contact in Realm Database: isFavorite:\(contact.isFavorite)")
    }
    
    
    func showContact(_ contact: Contacts) {
        self.selectedContact = contact
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 // we are showing 6 fields as per the pdf provided
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let row = indexPath.row
        if let selectedContact = self.selectedContact {
            if row == 0 && selectedContact.home.isEmpty {
                return 0 // Hide Home phone Cell
            }
            
            if row == 1 && selectedContact.mobile.isEmpty {
                return 0 // Hide Mobile phone Cell
            }
            
            if row == 2 && selectedContact.work.isEmpty {
                return 0 // Hide Work phone Cell
            }
        }

        return 125 // Height given to the cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! ContactDetailCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);
        cell.selectionStyle = .none
        cell.isHidden = false
        
        if let selectedContact = self.selectedContact {
            
            let phoneUpperCased = "Phone:".uppercased()
            
            let homeNumber = selectedContact.home
            let workNumber = selectedContact.work
            let mobileNumber = selectedContact.mobile
            let birthdate = selectedContact.birthdate
            let email = selectedContact.emailAddress
            let street = selectedContact.street
            let city = selectedContact.city + ","
            let state = selectedContact.state
            let country = selectedContact.country
            let zip = selectedContact.zipCode + ","
            
            let address = String(format: "%@ \n%@ %@ %@ %@", street, city, state, zip, country)
            
            switch indexPath.row {
            case 0:
                cell.keyLabel.text = phoneUpperCased
                cell.valueLabel.text = homeNumber.toPhoneNumber()
                cell.infoLabel.text = "Home"
                cell.tag = 0
            case 1:
                cell.keyLabel.text = phoneUpperCased
                cell.valueLabel.text = mobileNumber.toPhoneNumber()
                cell.infoLabel.text = "Mobile"
                cell.tag = 1
            case 2:
                cell.keyLabel.text = phoneUpperCased
                cell.valueLabel.text = workNumber.toPhoneNumber()
                cell.infoLabel.text = "Work"
            case 3:
                cell.keyLabel.text = "Address:".uppercased()
                cell.valueLabel.text = address
                cell.infoLabel.text = ""
            case 4:
                cell.keyLabel.text = "Birthdate:".uppercased()
                cell.valueLabel.text = Date.getFormattedDateString(dateString: birthdate)
                cell.infoLabel.text = ""
            case 5:
                cell.keyLabel.text = "Email:".uppercased()
                cell.valueLabel.text = email
                cell.infoLabel.text = ""
            default:
                cell.keyLabel.text = ""
                cell.valueLabel.text = ""
                cell.infoLabel.text = ""
            }
            
        }
        
        return cell
        
    }
}


// MARK: - ListCryptoCell
class ContactDetailCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
}
