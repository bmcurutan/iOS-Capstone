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
    @State private var isLoaded = false

    @State private var startersIsOn = true
    @State private var mainsIsOn = true
    @State private var dessertsIsOn = true
    @State private var drinksIsOn = true

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
                        .background(startersIsOn ? Color.capstoneYellow : Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            startersIsOn.toggle()
                        }

                    Spacer()
                    Text("Mains")
                        .padding()
                        .background(mainsIsOn ? Color.capstoneYellow : Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            mainsIsOn.toggle()
                        }
                    Spacer()
                    Text("Desserts")
                        .padding()
                        .background(dessertsIsOn ? Color.capstoneYellow : Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            dessertsIsOn.toggle()
                        }
                    Spacer()
                    Text("Drinks")
                        .padding()
                        .background(drinksIsOn ? Color.capstoneYellow : Color(hex: 0xD3D3D3))
                        .cornerRadius(8)
                        .onTapGesture {
                            drinksIsOn.toggle()
                        }
                    Spacer()
                }
                .padding(.bottom)

                FetchedObjects(predicate: buildPredicates(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
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

    private func buildPredicates() -> NSCompoundPredicate {
        guard searchText.isEmpty else {
            return NSCompoundPredicate(orPredicateWithSubpredicates: [NSPredicate(format: "title CONTAINS[cd] %@", searchText)])
        }

        var predicates: [NSPredicate] = []

        if startersIsOn {
            predicates.append(NSPredicate(format: "category == %@", "starters"))
        }

        if mainsIsOn {
            predicates.append(NSPredicate(format: "category == %@", "mains"))
        }

        if dessertsIsOn {
            predicates.append(NSPredicate(format: "category == %@", "desserts"))
        }

        if drinksIsOn {
            predicates.append(NSPredicate(format: "category == %@", "drinks"))
        }

        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
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
