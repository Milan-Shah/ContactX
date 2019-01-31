//
//  DetailProtocols.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

protocol DetailViewToPresenterProtocol: class {
    
    var view: DetailPresenterToViewProtocol? { get set }
    var interactor: DetailPresenterToInteractorProtocol? { get set }
    var router: DetailPresenterToRouterProtocol? { get set }
    func updateContact(_ contact: Contacts)
}

protocol DetailPresenterToViewProtocol: class {
    func showContact(_ contact: Contacts)
    func updatedContact (_ contact: Contacts)
}

protocol DetailPresenterToRouterProtocol: class {
    static func getContactModule(_ contact:Contacts) -> DetailViewController
}

protocol DetailPresenterToInteractorProtocol: class {
    var presenter:DetailInteractorToPresenterProtocol? { get set }
    func updateContactInRealm(_ contact: Contacts)
}

protocol DetailInteractorToPresenterProtocol {
    func updatedContact(_ contact: Contacts)
    func updateContactFailed()
}


