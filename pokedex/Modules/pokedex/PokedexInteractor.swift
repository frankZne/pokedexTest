//
//  PokedexInteractor.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation


class PokedexInteractor: PokedexInteractorProtocol {

    
    var presenter: PokedexOutputInteractorProtocol?
    


    
    func getAllPokemons(id: String) {
        ServicesAPI.shared.fetchPokemonDetail(id: id) { [weak self] result in
            switch result {
            case .success(let pokemonsResponse):
                DispatchQueue.main.async {
                    
                    print(pokemonsResponse)
                    self?.presenter?.onPokemonsRequestSuccess(data: pokemonsResponse)

                }
            case .failure(let error):
                print(error)
                self?.presenter?.onPokemonsRequestFailure()
            }
        }
        
    }
    
}
