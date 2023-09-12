//
//  ServicesAPI.swift
//  pokedex
//
//  Created by francisco rafael aguilar lugo on 11/09/23.
//

import Foundation

class ServicesAPI {
    
    public static let shared = ServicesAPI()
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    public func fetchAllPokemons(id: String ,result: @escaping (Result<PokemonsModel, APIServiceError>) -> Void) {
        let url = baseURL
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [
        URLQueryItem(name: "limit", value: "151")
        ]
        print(urlComponents.url)
        ApiCall.shared.fetchResources(url: urlComponents.url!, completion: result)
    }
    
    public func fetchPokemonDetail(id: String ,result: @escaping (Result<PokemonDetailModel, APIServiceError>) -> Void) {
        let url = baseURL + "/\(id)"
        var urlComponents = URLComponents(string: url)!
        urlComponents.path = id
        urlComponents.queryItems = []

        ApiCall.shared.fetchResources(url: URL(string: url)!, completion: result)
    }
    
}
