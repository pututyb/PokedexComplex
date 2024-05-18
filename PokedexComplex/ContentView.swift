//
//  ContentView.swift
//  PokedexComplex
//
//  Created by Putut Yusri Bahtiar on 29/03/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var vm = PokemonViewModel()
    @State private var searchQuery = ""
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(searchText: $searchQuery)
                    .padding(.top)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(vm.filterPokemonList(with: searchQuery), id: \.self) { pokemon in
                            NavigationLink(destination: PokemonDetailsView(pokemonDetail: vm.pokemonDetail(for: pokemon.name))) {
                                PokemonCardView(pokemon: pokemon, pokemonDetail: vm.pokemonDetail(for: pokemon.name))
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Fetch data only if it hasn't been fetched yet
            if vm.pokemonList.isEmpty {
                vm.getPoke()
            }
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search Pokémon", text: $searchText)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(4)
                .padding(.horizontal)
                .autocorrectionDisabled()
                .overlay(alignment: .trailing) {
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                        }
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
