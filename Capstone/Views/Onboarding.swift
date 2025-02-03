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

    @FocusState private var focused: Field?

    enum Field: Hashable {
        case firstName, lastName, email
    }

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                        EmptyView()
                    }

                Header()

                TextField("First Name", text: $firstName)
                    .focused($focused, equals: .firstName)
                    .padding()
                    .background(Rectangle()
                        .fill(.clear)
                        .border(.gray)
                    )
                    .padding([.top, .horizontal])
                    .onSubmit {
                        focused = .lastName
                    }
                TextField("Last Name", text: $lastName)
                    .focused($focused, equals: .lastName)
                    .padding()
                    .background(Rectangle()
                        .fill(.clear)
                        .border(.gray)
                    )
                    .padding([.top, .horizontal])
                    .onSubmit {
                        focused = .email
                    }
                TextField("Email", text: $email)
                    .focused($focused, equals: .email)
                    .padding()
                    .background(Rectangle()
                        .fill(.clear)
                        .border(.gray)
                    )
                    .padding()
                    .onSubmit {
                        registerButtonTapped()
                    }

                Spacer()
                
                Button("Register", action: {
                    registerButtonTapped()
                })
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.capstoneYellow)
                .foregroundColor(.black)
                .cornerRadius(8)
                .padding()
            }
        }
        .onAppear {
            isLoggedIn = UserDefaults.standard.bool(forKey: kIsLoggedIn)
        }
    }

    private func registerButtonTapped() {
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
