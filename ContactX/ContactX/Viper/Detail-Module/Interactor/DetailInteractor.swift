//
//  DetailInteractor.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


class DetailInteractor: DetailPresenterToInteractorProtocol {
    
    var presenter: DetailInteractorToPresenterProtocol?
    
    func updateContactInRealm(_ contact: Contacts) {
        
        var isFavorite = false
        if !contact.isFavorite {
            isFavorite = true
        }
        
        let realm = try! Realm()
        try! realm.write {
            contact.isFavorite = isFavorite
        }
        
        // update success
        self.presenter?.updatedContact(contact)
    }
    
}
