//
//  EditableButton.swift
//  SwiftUICheck
//
//  Created by Shivam Trivedi on 15/08/25.
//

import SwiftUI

struct EditableButton: View {
    @State private var animals = ["Cats", "Dogs", "Goats"]

    var body: some View {
        List {
            ForEach(animals, id: \.self) { animal in
                Text(animal)
            }.onDelete(perform: removeAnimal)
        }.toolbar {
            EditableButton()
        }
    }
    
    func removeAnimal(at offset: IndexSet) {
        animals.remove(atOffsets: offset)
    }
}

#Preview {
    NavigationStack {
        EditableButton()
    }
}
