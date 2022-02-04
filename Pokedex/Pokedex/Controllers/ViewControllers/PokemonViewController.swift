//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    private var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.delegate = self
        pokemonSearchBar.delegate = self
        pokemonMovesTableView.dataSource = self
        
    }
    // MARK: -Helper Func
    func updateViews(pokemon: Pokemon) {
        
        NetworkController.fetchImage(fromUrl: pokemon.spritePath) { spriteImage in
            guard let spriteImage = spriteImage else { return }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.pokemonSpriteImageView.image = spriteImage
                self.pokemonIDLabel.text = "ID: \(pokemon.id)"
                self.pokemonNameLabel.text = pokemon.name.capitalized
                self.pokemonMovesTableView.reloadData()
            }
            
        }
    }
    
    
}// End

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "moves"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let unwrappedPokemon = pokemon else { return 0 }
        return unwrappedPokemon.moves.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        guard let pokemon = pokemon else { return UITableViewCell()}
        let move = pokemon.moves[indexPath.row]
        cell.textLabel?.text = move
        
        return cell
    }
}
extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkController.fetchPokemon(name: searchText) { pokemon in
            guard let pokemon = pokemon else { return }
            self.updateViews(pokemon: pokemon)
        }
    }
}
