//
//  ButtonView.swift
//  Paletto
//
//  Created by Gina Mahaz on 11/25/25.
//

import Foundation
import SwiftUI

struct CellView: View {
    let row: Int
    let column: Int
    
    var body: some View {
        Text("\(row), \(column)")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .aspectRatio(1, contentMode: .fit) // Makes cells square (optional)
    }
}

