//
//  NetworkController.swift
//  Pokedex
//
//  Created by Brody Sears on 2/3/22.
//

import Foundation

class NetworkController {
    
    // MARK: - URL
    static private let baseURLString = "https://pokeapi.co/api/v2"
    //static private let urlPokeComponent = "/pokemon"
    
    // MARK: - Fetch Func
    static func fetchPokemon(name searchTerm: String, completion: @escaping ([Pokemon]?) -> Void ) {
        guard let baseURL = URL(string: baseURLString) else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/pokemon/\(searchTerm.lowercased())"
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
    }
    
}// end of class
