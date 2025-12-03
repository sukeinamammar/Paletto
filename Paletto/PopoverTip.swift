//
//  PopoverTip.swift
//  Paletto
//
//  Created by Sukeina Ammar on 12/3/25.
//

import SwiftUI
import TipKit


struct PopoverTipView: Tip {
    var title: Text {
        Text("Blob Word Randomizer")
    }
    
    var message: Text? {
        Text("This generator provides new word prompts to inspire your creativity.")
        
    }
    
    //var image: Image? {
        //Image("Info.tip.image")
}

struct PopoverTip: View {
     let popoverTipView = PopoverTipView()
    
    var body: some View {
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
            
            Spacer()
        }
            
        Spacer()
        Button("You go here") {
            
        }
        .popoverTip(popoverTipView, arrowEdge: .top)
        Spacer()
    }
}



#Preview {
    PopoverTip()
        .task {
            try? Tips.resetDatastore()
            
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
                
            ])
        }
}
