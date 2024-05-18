//
//  PokemonDetails.swift
//  PokedexComplex
//
//  Created by Putut Yusri Bahtiar on 04/05/24.
//

import Foundation

// MARK: - Temperatures
struct Temperatures: Codable, Identifiable {
    let abilities: [Ability]
//    let baseExperience: Int?
//    let cries: Cries
//    let forms: [Species]
//    let gameIndices: [GameIndex]
    let height: Int
    let held_items: [HeldItem]
    let id: Int
//    let isDefault: Bool
//    let locationAreaEncounters: String
//    let moves: [Move]
    let name: String
//    let order: Int
//    let pastAbilities: [String]
//    let pastTypes: [PastType]
    let sprites: Sprites
    let stats: [Stat]
//    let types: [TypeElement]
    let weight: Int
}

struct Ability: Codable, Hashable {
    let ability: AbilityInfo
}

struct AbilityInfo: Codable, Hashable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let back_default: String?
    let other: Other
}

struct Other: Codable {
    let dream_world: DreamWorld
    let home: OtherHome
}

struct DreamWorld: Codable {
    let front_default: String?
    let front_female: String?
}

struct OtherHome: Codable {
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct HeldItem: Codable, Hashable {
    let item: AbilityInfo
}

struct Stat: Codable, Hashable {
    let base_stat: Int
    let effort: Int
    let stat: InfoStat
}

struct InfoStat: Codable, Hashable {
    let name: String
}

let dummyAbilities: [Ability] = [
    Ability(ability: AbilityInfo(name: "Overgrow", url: "https://pokeapi.co/api/v2/ability/65/")),
    Ability(ability: AbilityInfo(name: "Touch Grass", url: "https://pokeapi.co/api/v2/ability/215/")),
    Ability(ability: AbilityInfo(name: "Touch Grass", url: "https://pokeapi.co/api/v2/ability/215/"))
]

let dummySprites = Sprites(
    back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png",
    other: Other(
        dream_world: DreamWorld(
            front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/10.svg",
            front_female: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/10-f.svg"
        ),
        home: OtherHome(
            front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/10.png",
            front_female: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/10-f.png",
            front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/10.png",
            front_shiny_female: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/10-f.png"
        )
    )
)

let dummyHelditem = [HeldItem(item: AbilityInfo(name: "moon-stone", url: "https://pokeapi.co/api/v2/item/81/"))]

let dummyStats = [Stat(base_stat: 70, effort: 2, stat: InfoStat(name: "hp")),Stat(base_stat: 48, effort: 0, stat: InfoStat(name: "defense")), Stat(base_stat: 60, effort: 0, stat: InfoStat(name: "special-attack")), Stat(base_stat: 65, effort: 0, stat: InfoStat(name: "special-defense")), Stat(base_stat: 35, effort: 0, stat: InfoStat(name: "speed"))]


let dummyPokemonDetail = Temperatures(
    abilities: dummyAbilities,
    height: 10, held_items: dummyHelditem,
    id: 10,
    name: "Clefairy",
    sprites: dummySprites, stats: dummyStats,
    weight: 10
)
