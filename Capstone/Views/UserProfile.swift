//
//  UserProfile.swift
//  Capstone
//
//  Created by Bianca Curutan on 1/30/25.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""

    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text("First Name: \(firstName)")
            Text("Last Name: \(lastName)")
            Text("Email: \(email)")

            Spacer()
            
            Button("Logout", action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                presentation.wrappedValue.dismiss()
            })
        }
    }

}

#Preview {
    UserProfile()
}
