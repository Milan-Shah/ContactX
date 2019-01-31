//
//  ListProtocols.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListViewToPresenterProtocol: class {
    
    var view: ListPresenterToViewProtocol? { get set }
    var interactor: ListPresenterToInteractorProtocol? { get set }
    var router: ListPresenterToRouterProtocol? { get set }
    func startFetchingContacts()
    func showContactDetail(forContact contact: Contacts)
}

protocol ListPresenterToViewProtocol: class {
    func showContacts(_ favoriteContacts: [Contacts], _ otherContacts: [Contacts])
    func showError()
}

protocol ListPresenterToRouterProtocol: class {
    static func createModule()-> ListViewController
    func showContactDetail(from view: ListPresenterToViewProtocol, forContact contact: Contacts)
}

protocol ListPresenterToInteractorProtocol: class {
    var presenter:ListInteractorToPresenterProtocol? { get set }
    var dataManager: ListInteractorToDataManagerProtocol? { get set }
    func fetchContactsList()
}

protocol ListInteractorToPresenterProtocol {
    func fetchedContactsSuccess(_ favoriteContacts: [Contacts], _ otherContacts: [Contacts])
    func fetchContactsFailed()
}

protocol ListInteractorToDataManagerProtocol {
    func retrieveSavedContacts() -> (Results<Contacts>, Results<Contacts>)?
    func saveFetchedContacts(contacts: [Contacts])
}
