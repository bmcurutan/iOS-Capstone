//
//  DishDetailView.swift
//  Capstone
//
//  Created by Bianca Curutan on 2/2/25.
//

import SwiftUI

struct DishDetailView: View {
    private var title: String
    private var category: String
    private var image: String
    private var price: String
    private var descr: String

    init(_ title: String, _ category: String, _ image: String, _ price: String, _ descr: String) {
        self.title = title
        self.category = category
        self.image = image
        self.price = price
        self.descr = descr
    }

    var body: some View {
        VStack() {
            Image("little-lemon-logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180)

            Text(title)
                .font(.title)

            Text(category.uppercased())
                .font(.caption)
                .foregroundColor(.gray)

            AsyncImage(url: URL(string: image)) { image in
                image.image?.resizable()
            }
            .frame(width: 300, height: 200)
            .cornerRadius(8)
            .padding(.top)

            Text("Price")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.capstoneGreen)
            Text("$\(price)")

            Text("Description")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.capstoneGreen)
            Text(descr)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }
    }
}

#Preview {
    let title = "Greek Salad"
    let category = "Starters"
    let image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
    let price = "$10.00"
    let descr = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
    DishDetailView(title, category, image, price, descr)
}
