//
//  PasteableButton.swift
//  SwiftUICheck
//
//  Created by Shivam Trivedi on 15/08/25.
//

import SwiftUI

struct PasteableButton: View {
    
    @State var textToPaste: String = String()
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding()
        }
        .navigationTitle("Paste Button")
    }
}

#Preview {
    NavigationStack {
        PasteableButton()
    }
}
