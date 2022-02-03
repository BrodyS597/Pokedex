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
    static func fetchPokemon(name searchTerm: String, completion: @escaping (Pokemon?) -> Void ) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/pokemon/\(searchTerm.lowercased())"
        
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
        
        //Data Task
        URLSession.shared.dataTask(with: finalURL) { taskData, _, error in
            if let error = error {
                print("There was an error fetching the data. The url is \(finalURL), the error is \(error.localizedDescription)")
                completion(nil)
            }
            guard let pokemonData = taskData else { return }
            
            do {
                //try
                if let topLevelDictionary = try JSONSerialization.jsonObject(with: pokemonData, options: .fragmentsAllowed) as? [String: Any] {
            
                    let pokemon = Pokemon(dictionary: topLevelDictionary)
                    completion(pokemon)
                }
            } catch {
                print("Encountered error when decoding the data:", error.localizedDescription)
                completion(nil)
            }
                    
        }.resume()
    }
    
}// end of class
