//
//  Header.swift
//  Capstone
//
//  Created by Bianca Curutan on 2/2/25.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Little Lemon")
                    .font(.largeTitle)
                    .foregroundColor(.capstoneYellow)
                Text("Chicago")
                    .font(.title2)
                    .foregroundColor(.white)
                Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.top)
            }
            .padding()

            Spacer()

            Image("food-item")
                .padding(.trailing)
        }
        .background(Color.capstoneGreen)
    }

}

#Preview {
    Header()
}
