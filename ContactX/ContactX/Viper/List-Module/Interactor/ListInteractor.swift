//
//  ListInteractor.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import Realm

class ListInteractor: ListPresenterToInteractorProtocol {
    
    var presenter: ListInteractorToPresenterProtocol?
    var dataManager: ListInteractorToDataManagerProtocol?
    
    func fetchContactsList() {

        if let savedContacts = self.retrieveSavedContacts() {
            print("Loading saved contacts from Realm")
            self.presenter?.fetchedContactsSuccess(savedContacts.0, savedContacts.1)
            return
        }
        
        let contactsQueue = DispatchQueue(label: "contacts.get.request-queue", qos: .utility, attributes: [.concurrent])
        let mainQueue = DispatchQueue.main

        Alamofire.request(CoreAPIs.contacts.getContactslist.url).responseJSON(queue: contactsQueue, options: .mutableLeaves) { (response) in
            
            guard let data = response.data else {
                mainQueue.async {
                    // Going back on Main to update View
                    print("Bad response: \(String(describing: response))")
                    self.presenter?.fetchContactsFailed()
                }
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                guard json is [AnyObject] else {
                    assert(false, "Failed to parse")
                    return
                }
                
                // Modeled [Contacts]
                let contacts = try jsonDecoder.decode([Contacts].self, from: data)
                
                mainQueue.async {
                    print("Recieved all the contacts. Persisting with Realm")
                    self.saveContacts(contacts)
                    
                    if let savedContacts = self.retrieveSavedContacts() {
                        print("Loading saved contacts from Realm")
                        self.presenter?.fetchedContactsSuccess(savedContacts.0, savedContacts.1)
                    }
                    
                }
                
            } catch let error {
                print(error.localizedDescription)
                mainQueue.async {
                    // Going back on Main to update View
                    print("Bad response: \(String(describing: response))")
                    self.presenter?.fetchContactsFailed()
                }
            }
            
        }
        
    }
    

}

extension ListInteractor {
    
    func saveContacts(_ contacts: [Contacts]) {
        
        let realm = try! Realm()
        
        for contact in contacts {
            try! realm.write {
                realm.add(contact, update: true)
            }
        }
        
    }
    
    func retrieveSavedContacts() -> (favorites: [Contacts], others: [Contacts])? {
        
        let realm = try! Realm()
        let contacts = realm.objects(Contacts.self)
        
        var favorites: [Contacts] = []
        var others: [Contacts] = []
        
        for contact in contacts {
            if contact.isFavorite {
                favorites.append(contact)
            } else {
                others.append(contact)
            }
        }
        
        // Sort Alphabetically and pass Tuple
        favorites = favorites.sorted { $0.name < $1.name }
        others = others.sorted { $0.name < $1.name }
        
        if favorites.count > 0 || others.count > 0 {
            return (favorites, others)
        }
        
        return nil
    }
    
}
