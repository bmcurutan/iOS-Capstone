//
//  DishDetailView.swift
//  Capstone
//
//  Created by Bianca Curutan on 2/2/25.
//

import SwiftUI

struct DishDetailView: View {
    private var title: String
    private var image: String
    private var price: String
    private var descr: String

    init(_ title: String, _ image: String, _ price: String, _ descr: String) {
        self.title = title
        self.image = image
        self.price = price
        self.descr = descr
    }

    var body: some View {
        VStack() {
            Image("little-lemon-logo")

            Text(title)
                .font(.title)

            AsyncImage(url: URL(string: image)) { image in
                image.image?.resizable()
            }
            .frame(width: 300, height: 200)
            .cornerRadius(8)

            Text("Price")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.secondary)
            Text("$\(price)")

            Text("Description")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.secondary)
            Text(descr)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()
        }

//            Rectangle()
//                .frame(height: 1)
//                .foregroundColor(Color.gray)
//                .padding(.horizontal)
//            
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(title)
//                        .font(.headline)
//                    Text("$\(formatPrice(price))")
//                        .font(.body)
//                        .foregroundColor(Color.capstoneGreen)
//                    Text("\n\(category.uppercased())")
//                        .font(.caption)
//                        .foregroundColor(Color.gray)
//                }
//                Spacer()
//
//            }
//            .padding()
//        }
    }
}

#Preview {
    let title = "Greek Salad"
    let image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
    let price = "$10.00"
    let descr = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
    DishDetailView(title, image, price, descr)
}
