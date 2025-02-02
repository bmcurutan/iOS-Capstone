//
//  Menu.swift
//  Capstone
//
//  Created by Bianca Curutan on 1/30/25.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""

    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")

            TextField("Search menu", text: $searchText)

            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.id) { dish in
                        HStack {
                            Text("\(dish.title!) $\(dish.price!)")
                            Spacer()
                            AsyncImage(url: URL(string: dish.image!)) { image in
                                image.image?.resizable()
                            }
                            .frame(width: 80, height: 80)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear() {
            getMenuData()
        }
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
                }
                try? viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    private func buildPredicate() -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
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
