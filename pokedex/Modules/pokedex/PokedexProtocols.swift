//
//  PokedexProtocols.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation
import UIKit



protocol PokedexViewProtocol: class {
    // Presenter -> View
    //func showLoader()
    //func hideLoader()

    func getPokemonsRequestSuccess(dataPokemon: PokemonDetailModel, sprites: [String])
    func getPokemonsRequestFailure()
}

protocol PokedexPresenterProtocol: class {
    // View -> Presenter
    var interactor: PokedexInteractorProtocol? {get set}
    var view: PokedexViewProtocol? {get set}
    var router: PokedexRouterProtocol? {get set}
    func getPokemonsPresenter(id: String)
}

protocol PokedexInteractorProtocol: class {
    // Presenter -> Interactor
    var presenter: PokedexOutputInteractorProtocol? {get set}
    func getAllPokemons(id: String)
}

protocol PokedexOutputInteractorProtocol: class {
    // Interactor -> PresenterOutput
    func onPokemonsRequestSuccess(data: PokemonDetailModel)
    func onPokemonsRequestFailure()
}

protocol PokedexRouterProtocol: class {
    //Presenter -> Wireframe
    static func createModule() -> UIViewController
}
