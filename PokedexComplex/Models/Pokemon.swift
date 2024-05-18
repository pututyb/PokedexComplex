//
//  Pokemon.swift
//  PokedexComplex
//
//  Created by Putut Yusri Bahtiar on 04/05/24.
//

import Foundation

struct PokemonModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [ResultsPokemon]
}

struct ResultsPokemon: Codable, Hashable {
    let name: String
    let url: String
}
