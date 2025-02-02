//
//  Header.swift
//  Capstone
//
//  Created by Bianca Curutan on 2/2/25.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle)
//                .fore
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
        }
        .padding()
    }

}

#Preview {
    Header()
}
