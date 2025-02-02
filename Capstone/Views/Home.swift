//
//  Home.swift
//  Capstone
//
//  Created by Bianca Curutan on 1/30/25.
//

import SwiftUI

struct Home: View {
    let persistence = PersistenceController.shared

    var body: some View {
        TabView {
            Menu()
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    Home()
}
