//
//  DetailPresenter.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class DetailPresenter: DetailViewToPresenterProtocol {

    var view: DetailPresenterToViewProtocol?
    var interactor: DetailPresenterToInteractorProtocol?
    var router: DetailPresenterToRouterProtocol?
    
    func updateContact(_ contact: Contacts) {
        interactor?.updateContactInRealm(contact)
    }
    
}

extension DetailPresenter: DetailInteractorToPresenterProtocol {
    
    func updatedContact(_ contact: Contacts) {
        view?.updatedContact(contact)
    }
    
    func updateContactFailed() {
        // need to show error
    }
    
}
