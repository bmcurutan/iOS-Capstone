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
            Image("little-lemon-logo")
            
            Text("Personal Information")
                .font(.title)

            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .padding(.bottom)

            Text("First Name")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.secondary)
            Text(firstName)

            Text("Last Name")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.secondary)
            Text(lastName)

            Text("Email")
                .font(.headline)
                .padding(.top)
                .foregroundColor(.secondary)
            Text(email)

            Spacer()
            
            Button("Logout", action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                presentation.wrappedValue.dismiss()
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.capstoneYellow)
            .foregroundColor(Color.black)
            .cornerRadius(8)
            .padding()
        }
    }
}

#Preview {
    UserProfile()
}
