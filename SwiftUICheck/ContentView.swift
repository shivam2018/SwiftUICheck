//
//  ContentView.swift
//  SwiftUICheck
//
//  Created by Shivam Trivedi on 08/08/25.
//

import SwiftUI
 
struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            VStack (spacing: 50){
                NavigationLink("Button"){
                    Buttons()
                }
                
                NavigationLink("Edit") {
                    EditableButton()
                }
                
                NavigationLink("Edit") {
                    PasteableButton()
                }
                
                NavigationLink("Check") {
                    Text("Checking Navigation link")
                        .padding(40)
                        .navigationTitle("Checking")
                }
            }
            
        }
        .navigationTitle("Home")
        
    }
}

#Preview {
    ContentView()
}
