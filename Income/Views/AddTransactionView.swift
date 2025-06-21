//
//  AddTransactionView.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 10/06/25.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State private var amount: Double = 0.00
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @Binding var transactions: [Transaction]
    var transactionToEdit: Transaction?
    @Environment(\.dismiss) var dismiss
    @AppStorage("currency") var currency: Currency = .brl
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = currency.locale
        return formatter
    }
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight:.thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(Color(uiColor: .lightGray))
                .frame(height: 0.3)
                .padding(.horizontal, 30)
            Picker("Shoose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 20))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count > 2 else {
                    alertTitle = "Title invalid"
                    alertMessage = "Title must have more than 2 characters"
                    showAlert = true
                    return
                }
                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransactionToEdit = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now"
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransactionToEdit] = transaction
                } else {
                    transactions.append(transaction)
                }
                dismiss()
            }, label: {
                Text(transactionToEdit == nil ? "Create": "Update")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .cornerRadius(6)
            })
            .padding(.horizontal, 30)
            .padding(.top, 40)
            Spacer()
                
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
                
                
            }
        })
        .padding(.top, 40)
        .alert(alertTitle, isPresented: $showAlert) {
            Button(action: {
                
            }, label: {
                Text("Ok")
            })
        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
