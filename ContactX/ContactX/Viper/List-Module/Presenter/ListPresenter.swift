//
//  ListPresenter.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class ListPresenter: ListViewToPresenterProtocol {

    var view: ListPresenterToViewProtocol?
    var interactor: ListPresenterToInteractorProtocol?
    var router: ListPresenterToRouterProtocol?
    var dataManager: ListInteractorToDataManagerProtocol?
    
    func startFetchingContacts() {
        interactor?.fetchContactsList()
    }
    
    func showContactDetail(forContact contact: Contacts) {
        router?.showContactDetail(from: view!, forContact: contact)
    }
}

extension ListPresenter: ListInteractorToPresenterProtocol {
    
    func fetchedContactsSuccess(_ favoriteContacts: [Contacts], _ otherContacts: [Contacts]) {
        view?.showContacts(favoriteContacts, otherContacts)
    }
    
    func fetchContactsFailed() {
        view?.showError()
    }
    
}
