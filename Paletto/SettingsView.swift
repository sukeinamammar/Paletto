//
//  SettingsView.swift
//  Paletto
//
//  Created by Sukeina Ammar on 12/2/25.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Display")) {
                    
                    Toggle(isOn: .constant(true),
                           label: {
                        Text("Chord Mode")
                        
                    })
                    
                    Toggle(isOn: .constant(false),
                           label: {
                        Text("Word Mode")
                    })
                }
            }
            .navigationTitle("Setting")
        }
    }
}
                


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}





#Preview {
    SettingsView()
}
