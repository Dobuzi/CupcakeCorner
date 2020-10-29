//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by 김종원 on 2020/10/28.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var order: OrderStruct
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                    Spacer()
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: geo.size.width - 40, height: 60)
                        .background(Color.red.opacity(errorMessage == "" ? 0 : 0.7))
                        .cornerRadius(15)
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.errorMessage = "No data in response: \(error?.localizedDescription ?? "Unknown error")."
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                self.errorMessage = "Invalid response from server"
            }
        }.resume()
    }
}
