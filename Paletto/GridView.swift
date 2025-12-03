import SwiftUI
import TipKit


enum PlayMode: String, CaseIterable {
    case chord = "Chord Mode"
    case single = "Single Note Mode"
}

struct GridView: View {
    @State private var selectedMode: PlayMode = .chord
    @State private var showAccessibilitySheet = false
    @State private var showLabels = true   // <- controls labels on blocks
    
    let rows = 7
    let columns = 3
    
    let colors: [Color] = [
        .purple, .purple.mix(with: .white, by: 0.50), .purple.mix(with: .black, by: 0.50),
        .yellow, .orange, .red,
        .brown, .indigo, .black
    ]
    
    let sounds: [String] = [
        "sound_0_0", "sound_0_1", "sound_0_2",
        "sound_1_0", "sound_1_1", "sound_1_2",
        "sound_2_0", "sound_2_1", "sound_2_2",
        "sound_3_0", "sound_3_1", "sound_3_2",
        "sound_4_0", "sound_4_1", "sound_4_2",
        "sound_5_0", "sound_5_1", "sound_5_2",
        "sound_6_0", "sound_6_1", "sound_6_2"
    ]
    
    let popoverTipView = PopoverTipView()
    
    var body: some View {
        NavigationStack {
            Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                ForEach(0..<rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<columns, id: \.self) { column in
                            
                            let index = (row * columns + column) % colors.count
                            let color = colors[index]
                            let soundName = sounds[index]
                            
                            Button {
                                SoundManager.shared.playSound(named: soundName)
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(color)
                                        .frame(width: 95, height: 95)
                                    
                                    if showLabels {
                                        Text("(\(row), \(column))")   // or your note names later
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        
            .toolbar {
                // Left: mode menu (with checkmark)
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(PlayMode.allCases, id: \.self) { mode in
                            Button {
                                selectedMode = mode
                            } label: {
                                HStack {
                                    Text(mode.rawValue)
                                    if mode == selectedMode {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                    }
                    .popoverTip(popoverTipView, arrowEdge: .leading)
                }
                
                
                
                // Right: Accessibility button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAccessibilitySheet = true
                    } label: {
                        Label("Accessibility", systemImage: "figure.wave")
                            .labelStyle(.iconOnly)
                            .font(.title2)
                    }
            
                }
                
            }
            // Accessibility sheet
            .sheet(isPresented: $showAccessibilitySheet) {
                NavigationStack {
                    Form {
                        Section("Visual Labels") {
                            Toggle(isOn: $showLabels) {
                                Text("Show labels on color blocks")
                            }
                            
                            Text("Turn this on to see text labels on each block. Turn it off for a purely color-based experience.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .navigationTitle("Accessibility")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                showAccessibilitySheet = false
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GridView()
        .task {
            try? Tips.resetDatastore()
            
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
                
            ])
        }
}

