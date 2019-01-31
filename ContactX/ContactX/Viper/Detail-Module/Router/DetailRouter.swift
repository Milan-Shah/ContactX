//
//  DetailRouter.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter: DetailPresenterToRouterProtocol {
   
    static func getContactModule(_ contact:Contacts) -> DetailViewController {
        
        let view = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let presenter: DetailViewToPresenterProtocol & DetailInteractorToPresenterProtocol = DetailPresenter()
        let interactor: DetailPresenterToInteractorProtocol = DetailInteractor()
        let router: DetailPresenterToRouterProtocol = DetailRouter()
        
        view.presenter = presenter
        view.selectedContact = contact
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
