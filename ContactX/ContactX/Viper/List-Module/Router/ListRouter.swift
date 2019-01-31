//
//  ListRouter.swift
//  ContactX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

class ListRouter: ListPresenterToRouterProtocol {

    static func createModule() -> ListViewController {
        
        let view = mainStoryboard.instantiateViewController(withIdentifier: "ContactsListViewController") as! ListViewController
        let presenter: ListViewToPresenterProtocol & ListInteractorToPresenterProtocol = ListPresenter()
        let interactor: ListPresenterToInteractorProtocol = ListInteractor()
        let router: ListPresenterToRouterProtocol = ListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func showContactDetail(from view: ListPresenterToViewProtocol, forContact contact: Contacts) {
        
        let detailView = DetailRouter.getContactModule(contact)
        if let view = view as? UIViewController {
            view.navigationController?.pushViewController(detailView, animated: true)
        }
        
    }
}
