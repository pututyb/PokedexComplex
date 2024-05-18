//
//  PokemonDetailsView.swift
//  PokedexComplex
//
//  Created by Putut Yusri Bahtiar on 08/05/24.
//

import SwiftUI
import Kingfisher

struct PokemonDetailsView: View {
    
    let pokemonDetail: Temperatures?
    @State private var flipped = false
    
    var body: some View {
        VStack {
            ZStack {
                Color.orange
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                
                KFImage.url(URL(string: pokemonDetail?.sprites.other.home.front_default ?? ""))
                    .resizable()
                    .frame(width: 250, height: 250)
                    .rotation3DEffect(
                        .degrees(flipped ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    .animation(.default, value: flipped)
                    .onTapGesture {
                        flipped.toggle()
                    }
            }
            
            Text(pokemonDetail?.name.capitalized ?? "Unknown".capitalized)
                .font(.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .top])
            
            Text("\(pokemonDetail?.id ?? 0)")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            TopRoundedRectangle(radius: 25)
                .fill(Color.black.opacity(0.9))
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(edges: .bottom)
                .overlay {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .center) {
                                    HStack {
                                        Image(systemName: "scalemass")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(.gray)
                                        Text("Weight")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.vertical)
                                    
                                    Text("\(pokemonDetail?.weight ?? 0)Kg")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24, weight: .bold))
                                        .padding(.leading)
                                }
                                .padding(.leading)
                                
                                Spacer()
                                
                                VStack(alignment: .center) {
                                    HStack {
                                        Image(systemName: "figure.walk")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundStyle(.gray)
                                        Text("Height")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.vertical)
                                    
                                    Text("\(pokemonDetail?.height ?? 0)M")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 24, weight: .bold))
                                        .padding(.trailing)
                                }
                                .padding(.trailing)
                                
                            }
                            
                            Text("Held Items")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                            
                            ForEach(pokemonDetail?.held_items ?? [], id: \.self) { heldItem in
                                HStack {
                                    Text(heldItem.item.name.capitalized)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                            }
                            
                            Text("Abilities")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                            
                            ForEach(pokemonDetail?.abilities ?? [], id: \.self) { ability in
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                    
                                    Text(ability.ability.name.capitalized)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.white)
                                }
                                .padding(.leading)
                            }
                            
                            Text("Stats")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundStyle(.white)
                                .padding()
                            
                            ForEach(pokemonDetail?.stats ?? [], id: \.self) { stat in
                                HStack {
                                    Text("\(stat.stat.name.capitalized) :")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 14, weight: .semibold))
                                    Text("\(stat.base_stat)")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(.white)
                                }
                                .padding()
                            }
                        }
                    }
                }
            Spacer()
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TopRoundedRectangle: Shape {
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        _ = rect.height
        let maxY = rect.maxY
        
        path.move(to: CGPoint(x: 0, y: maxY))
        path.addLine(to: CGPoint(x: 0, y: radius))
        path.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addArc(center: CGPoint(x: width - radius, y: radius), radius: radius, startAngle: .degrees(270), endAngle: .degrees(360), clockwise: false)
        path.addLine(to: CGPoint(x: width, y: maxY))
        
        return path
    }
}


#Preview {
    PokemonDetailsView(pokemonDetail: dummyPokemonDetail)
}
