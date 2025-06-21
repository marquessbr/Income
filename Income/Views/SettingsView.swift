//
//  SettingsView.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 18/06/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("orderDescending") var orderDescending: Bool = false
    @AppStorage("currency") var currency: Currency = .brl
    @AppStorage("filterMinimum") var filterMinimum: Double = 0
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = currency.locale
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Toggle(isOn: $orderDescending) {
                        Text("Order \(orderDescending ? "(Earliest)" : "(Latest)")")
                    }
                }
                HStack {
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.title)
                        }
                    }
                }
                HStack {
                    Text("Filter Minimum")
                    TextField("", value: $filterMinimum, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                }
            }
            .padding(.top)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
