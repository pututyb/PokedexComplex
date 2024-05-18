//
//  PokemonViewModel.swift
//  PokedexComplex
//
//  Created by Putut Yusri Bahtiar on 04/05/24.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [ResultsPokemon] = []
    @Published var pokemonDetails: [Temperatures] = []
    private var cancellables = Set<AnyCancellable>()
    private var nextURL: String?
    
    func getPoke() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        
        fetchPokemon(from: url)
        detailPoke()
    }
    
    func detailPoke() {
        for pokemon in pokemonList {
            fetchPokemonDetails(from: pokemon)
        }
    }
    
    func fetchPokemon(from url: URL) {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .decode(type: PokemonModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let  error):
                    print("Error loading data: \(error)")
                }
            } receiveValue: { pokemonModel in
                self.pokemonList.append(contentsOf: pokemonModel.results)
                self.nextURL = pokemonModel.next
                
                // If there's a next URL, fetch the next page recursively
                if let nextURL = self.nextURL, let url = URL(string: nextURL) {
                    self.fetchPokemon(from: url)
                } else {
                    self.detailPoke()
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPokemonDetails(from pokemon: ResultsPokemon) {
        guard let url = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .decode(type: Temperatures.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case.finished:
                    print("pokeDetailsFinish")
                case.failure(let error):
                    print("Error loading data: \(error)")
                }
            } receiveValue: { data in
                self.pokemonDetails.append(data)
            }
            .store(in: &cancellables)
    }
    
    func pokemonDetail(for name: String) -> Temperatures? {
        return pokemonDetails.first { $0.name == name }
    }
    
    func filterPokemonList(with query: String) -> [ResultsPokemon] {
        guard !query.isEmpty else { return pokemonList }
        return pokemonList.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
    
}
