//
//  DishView.swift
//  Capstone
//
//  Created by Bianca Curutan on 2/2/25.
//

import SwiftUI

struct DishView: View {
    private var title: String
    private var image: String
    private var price: String
    private var category: String

    init(_ title: String, _ image: String, _ price: String, _ category: String) {
        self.title = title
        self.image = image
        self.price = price
        self.category = category
    }

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
                .padding(.horizontal)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                    Text("$\(price)")
                        .font(.body)
                        .foregroundColor(Color.capstoneGreen)
                    Text("\n\(category.uppercased())")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                AsyncImage(url: URL(string: image)) { image in
                    image.image?.resizable()
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    let title = "Greek Salad"
    let image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
    let price = "$10.00"
    let category = "starters"
    DishView(title, image, price, category)
}
