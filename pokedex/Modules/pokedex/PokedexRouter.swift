//
//  PokedexRouter.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation
import UIKit



class PokedexRouter: PokedexRouterProtocol {
    static func createModule() -> UIViewController {
        let view = PokedexViewController()
        let routerPC: PokedexRouterProtocol = PokedexRouter()
        let presenter: PokedexPresenterProtocol & PokedexOutputInteractorProtocol = PokedexPresenter()
        let interactor: PokedexInteractorProtocol = PokedexInteractor()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = routerPC
        interactor.presenter = presenter
        view.presenter = presenter
        
        return view
    }
}
