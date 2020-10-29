//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by 김종원 on 2020/10/28.
//

import SwiftUI

struct AddressView: View {
    @Binding var order: OrderStruct
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip code", text: $order.zip)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: $order)) {
                    Text("Check out")
                }
            }
            .disabled(!order.hasValidAddress)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}
