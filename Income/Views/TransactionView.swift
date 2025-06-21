//
//  TransactionView.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 10/06/25.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    @AppStorage("currency") var currency: Currency = .brl
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Spacer()
                Text(transaction.displayDate)
                    .font(.system(size: 16))
                    .padding(.trailing, 15)
            }
            .padding(.vertical, 5)
            .background(Color.lightGrayShade)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            HStack {
                Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16) .weight(.bold))
                    .foregroundStyle(transaction.type == .income ? Color.green: Color.red)
                    .padding(.trailing,10)
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text (transaction.title)
                            .font(.system(size: 16) .weight(.bold))
                        Spacer()
                        Text(transaction.displayAmount(currency: currency))
                            .font(.system(size: 16) .bold())
                            .padding(.trailing, 15)
                        
                    }
                    Text ("Completed")
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}

#Preview {
    TransactionView(transaction: Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()))
}
