//
//  PokedexPresenter.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation


class PokedexPresenter: PokedexPresenterProtocol {
    var interactor: PokedexInteractorProtocol?
    var view: PokedexViewProtocol?
    var router: PokedexRouterProtocol?
    
    func getPokemonsPresenter(id: String) {
        self.interactor?.getAllPokemons(id: id)
    }
    
    

}

extension PokedexPresenter: PokedexOutputInteractorProtocol {
    func onPokemonsRequestFailure() {
        view?.getPokemonsRequestFailure()
    }
    
    func onPokemonsRequestSuccess(data: PokemonDetailModel) {
        
        var spritesData = [String]()
        
        if let spriteSafeUnwrap = data.sprites {
            spritesData.append(spriteSafeUnwrap.frontDefault ?? "")
            spritesData.append(spriteSafeUnwrap.backDefault ?? "")
            spritesData.append(spriteSafeUnwrap.backShiny ?? "")
            spritesData.append(spriteSafeUnwrap.frontShiny ?? "")
            spritesData.append(spriteSafeUnwrap.animated?.frontDefault ?? "")
            spritesData.append(spriteSafeUnwrap.backFemale ?? "")
            spritesData.append(spriteSafeUnwrap.backShiny ?? "")
        }
        


        
        
        
        view?.getPokemonsRequestSuccess(dataPokemon: data, sprites: spritesData)
    }
    
}
