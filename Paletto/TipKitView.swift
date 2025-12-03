//
//  TipKitView.swift
//  Paletto
//
//  Created by Sukeina Ammar on 12/3/25.
//

import SwiftUI
import TipKit


@main

struct TipKitView: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    try? Tips.configure([
//                       .displayFrequency(.immediate),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
        }
    }
}
