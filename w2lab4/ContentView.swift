//
//  ContentView.swift
//  w2lab4
//
//  Created by Juhaina on 16/01/1445 AH.
//

import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

struct ContentView: View {
    @State private var searchQuery = ""
    var dummyData = [ListItem(title: "Item1", icon: "icon1"), ListItem(title: "Item2", icon: "icon2"), ListItem(title: "Item3", icon: "icon3")]

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search...", text: $searchQuery)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                List(dummyData.filter { searchQuery.isEmpty ? true : $0.title.contains(searchQuery) }, id: \.id) { item in
                    NavigationLink(destination: DetailView(item: item.title)) {
                        HStack {
                            Image(systemName: item.icon)
                            Text(item.title)
                        }
                    }
                }
                .animation(.default)
                
                SignUpForm()
            }
        }
    }
}

struct DetailView: View {
    var item: String

    var body: some View {
        Text("You selected \(item)")
    }
}

struct SignUpForm: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                if showError {
                    Text("Invalid email or password")
                        .foregroundColor(.red)
                }
            }
            Button(action: {
                if isValidEmail(email) && password.count >= 8 {
                    // Sign up action
                    print("Sign Up Successful")
                } else {
                    showError = true
                }
            }) {
                Text("Sign Up")
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
       
        return email.contains("@")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
