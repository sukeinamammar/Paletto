import SwiftUI

struct MenuView: View {
    @State private var selectedMode: PlayMode = .chord
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Current mode:")
                    .font(.headline)
                
                Text(selectedMode.rawValue)
                    .font(.title2)
                    .bold()
            }
            .navigationTitle("Modes")
            .toolbar {
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
                }
            }
        }
    }
}

#Preview {
    MenuView()
}

