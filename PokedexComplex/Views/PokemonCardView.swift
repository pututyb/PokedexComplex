//
//  PokemonCardView.swift
//  PokedexComplex
//
//  Created by Putut Yusri Bahtiar on 08/05/24.
//

import SwiftUI
import Kingfisher

struct PokemonCardView: View {
    let pokemon: ResultsPokemon
    let pokemonDetail: Temperatures?
    
    var body: some View {
        VStack(spacing: 20) {
            if let pokemonDetail = pokemonDetail,
               let frontDefaultURLString = pokemonDetail.sprites.other.home.front_default,
               let frontDefaultURL = URL(string: frontDefaultURLString) {
                KFImage(frontDefaultURL)
                    .resizable()
                    .frame(width: 150, height: 150)
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            
            Text(pokemon.name)
                .font(.system(size: 24, weight: .bold))
            
            Text("#\(pokemonDetail?.id ?? 0)")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blur(radius: 10)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        )
    }
}


#Preview {
    PokemonCardView(pokemon: ResultsPokemon(name: "Bulbasaur", url: ""), pokemonDetail: nil)
}
