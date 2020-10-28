//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by 김종원 on 2020/10/27.
//

import SwiftUI

struct ContentView: View {
    @State private var userName = ""
    @State private var email = ""
    
    var disableForm: Bool {
        userName.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
