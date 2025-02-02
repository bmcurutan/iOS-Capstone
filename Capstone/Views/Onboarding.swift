//
//  Onboarding.swift
//  Capstone
//
//  Created by Bianca Curutan on 1/30/25.
//

import SwiftUI

let kFirstName = "kFirstName"
let kLastName = "kLastName"
let kEmail = "kEmail"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }

                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)

                Spacer()
                
                Button("Register", action: {
                    if !firstName.isEmpty {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                    }
                    if !lastName.isEmpty {
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                    }
                    if !email.isEmpty && isValidEmail(email) {
                        UserDefaults.standard.set(email, forKey: kEmail)
                    }

                    isLoggedIn = !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email)
                    UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)
                })
            }
            .padding()
        }
        .onAppear {
            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
