//
//  Menu.swift
//  Capstone
//
//  Created by Bianca Curutan on 1/30/25.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var category: String?
    @State private var isLoaded = false

    var body: some View {
        ScrollView {
            VStack {
                Image("little-lemon-logo")

                Header()

                ZStack {
                    TextField("Search menu", text: $searchText)
                        .padding()
                        .background(Rectangle()
                            .fill(Color.white)
                            .border(Color.gray)
                        )
                        .padding()
                }
                .background(Color.capstoneGreen)
                .padding(.top, -8)

                Text("ORDER FOR DELIVERY")
                    .font(.headline)
                    .padding()

                HStack() {
                    Spacer()
                    Text("Starters")
                        .padding()
                        .background(Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            category = category == nil || category != "starters" ? "starters" : nil
                            let _ = buildPredicate()
                        }
                    Spacer()
                    Text("Mains")
                        .padding()
                        .background(Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            category = category == nil || category != "mains" ? "mains" : nil
                            let _ = buildPredicate()
                        }
                    Spacer()
                    Text("Desserts")
                        .padding()
                        .background(Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            category = category == nil || category != "desserts" ? "desserts" : nil
                            let _ = buildPredicate()
                        }
                    Spacer()
                    Text("Drinks")
                        .padding()
                        .background(Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            category = category == nil || category != "drinks" ? "drinks" : nil
                            let _ = buildPredicate()
                        }
                    Spacer()
                }
                .padding(.bottom)

                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    ForEach(dishes, id: \.id) { dish in

                        NavigationLink(destination: DishDetailView(dish.title!, dish.image!, formatPrice(dish.price!), dish.descr!)) {
                            DishView(dish.title!, dish.image!, formatPrice(dish.price!), dish.category!)
                        }
                    }
                }
            }
            .onAppear() {
                if !isLoaded {
                    getMenuData()
                    isLoaded = true
                }
            }
        }
    }

    private func formatPrice(_ price: String) -> String {
        guard let intPrice = Int(price) else { return "0.00" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: intPrice)) ?? "0.00"
    }

    private func getMenuData() {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data,_,_ in
            guard let data else { return }

            PersistenceController.shared.clear()
            let decoder = JSONDecoder()
            do {
                let menuList = try decoder.decode(MenuList.self, from: data)
                menuList.menu.forEach { menuItem in
                    let dish = Dish(context: viewContext)
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.price = menuItem.price
                    dish.category = menuItem.category
                    dish.descr = menuItem.description
                }
                try? viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    private func buildPredicate() -> NSPredicate {
        if let category {
            return NSPredicate(format: "category == %@", category)
        } else {
            return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }

    private func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
            ]
    }

}

#Preview {
    Menu()
}
