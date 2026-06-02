//
//  Buttons.swift
//  SwiftUICheck
//
//  Created by Shivam Trivedi on 15/08/25.
//

import SwiftUI

struct Buttons: View {
   @State private var count = 0
    
    var body: some View {
        VStack {
            Text("This is a button example")
            Text("Count value is: \(count)")
                .padding()
            Button {
                count += 1
            } label: {
                Text("Tap to Increment count")
                    .fontWeight(.bold)
                    .foregroundStyle(.yellow)
                    .padding()
                    .background(.black)
                    .clipShape(Capsule())
            }
        }
    }
}

#Preview {
    NavigationStack {
        Buttons()
    }
}
