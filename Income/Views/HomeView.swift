//
//  HomeView.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 09/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Bananas", type: .income, amount: 10.00, date: Date()),
    ]
    @State private var showAddTransactionView: Bool = false
    @State private var transaction: Transaction?
    @State private var transactionToEdit: Transaction?
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
                    
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    VStack {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        Text("$2")
                            .font(.system(size: 40, weight: .light))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .padding(.top)
                HStack(spacing: 40) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("$22")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("$22")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List {
                        ForEach(transactions) { transaction in
                            Button(action:{
                                transactionToEdit = transaction
                            }, label:{
                                TransactionView(transaction: transaction)
                            })
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: {transation in
                AddTransactionView(transactions: $transactions, transactionToEdit: transation)
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView(transactions: $transactions)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    })
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
