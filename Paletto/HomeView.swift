//
//  HomeView.swift
//  Paletto
//
//  Created by Sukeina Ammar on 11/29/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // Outer background
            Color(red: 0.80, green: 0.84, blue: 0.82) // grey-green
                .ignoresSafeArea()

            VStack {
                Spacer(minLength: 16)

                
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .fill(Color(red: 0.93, green: 0.91, blue: 0.83))
                // light beige background^
                
                
                    .overlay(
                        VStack(spacing: 28) {

                
                            Image("palettoLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 260)
                                .padding(.top, 12)

                            // the first line when a user opens the app
                            Text("Play Music with color")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.black)

                            // mode cards
                            VStack(spacing: 20) {
                                ModeCard(
                                    title: "Explore Mode",
                                    subtitle: "Tap colors based on the words",
                                    background: Color(red: 0.77, green: 0.82, blue: 0.88),
                                    palette: [
                                        Color(red: 0.53, green: 0.16, blue: 0.08),
                                        Color(red: 0.82, green: 0.27, blue: 0.12),
                                        Color(red: 0.98, green: 0.56, blue: 0.47),
                                        Color(red: 0.68, green: 0.45, blue: 0.13),
                                        Color(red: 1.00, green: 0.74, blue: 0.26),
                                        Color(red: 1.00, green: 0.86, blue: 0.63)
                                    ],
                                    tapAction: {
                                        // navigate to Explore Mode
                                    }
                                )

                                ModeCard(
                                    title: "Standard Mode",
                                    subtitle: "Tap colors and learn the sounds",
                                    background: Color(red: 0.79, green: 0.90, blue: 0.84),
                                    palette: [
                                        Color(red: 0.24, green: 0.06, blue: 0.29),
                                        Color(red: 0.34, green: 0.03, blue: 0.36),
                                        Color(red: 0.89, green: 0.76, blue: 1.00),
                                        Color(red: 0.13, green: 0.02, blue: 0.23),
                                        Color(red: 0.24, green: 0.11, blue: 0.66),
                                        Color(red: 0.43, green: 0.35, blue: 0.98)
                                    ],
                                    tapAction: {
                                        // navigate to Standard Mode
                                    }
                                )
                            }

                            Spacer(minLength: 12)
                            
//want to make this lighter in tone
                            Text("Tap a mode to begin")
                                .font(.title3.weight(.medium))
                                .foregroundColor(.black.opacity(0.85))
                                .padding(.bottom, 12)
                        }
                        .padding(.horizontal, 28)
                        .padding(.vertical, 24)
                    )
                    .padding(.horizontal, 16)

                Spacer(minLength: 24)
            }
        }
    }
}

//picking a mode cards

struct ModeCard: View {
    let title: String
    let subtitle: String
    let background: Color
    let palette: [Color]
    let tapAction: () -> Void

    private let columns = [
        GridItem(.fixed(56)),
        GridItem(.fixed(56))
    ]

    var body: some View {
        Button(action: tapAction) {
            HStack(spacing: 18) {
                // this is for the color grid
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(0..<min(palette.count, 6), id: \.self) { index in
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(palette[index])
                            .frame(width: 56, height: 56)
                            .shadow(radius: 2, y: 1)
                    }
                }

                // Text stack
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .layoutPriority(1)

                    Text(subtitle)
                        .font(.body)
                        .foregroundColor(.black.opacity(0.7))
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()
            }
            .padding(22)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 35, style: .continuous)
                .fill(background)
                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 6)
        )
    }
}

//preview structure

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 15 Pro")
    }
}
