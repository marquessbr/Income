//
//  HomeView.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 09/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .income, amount: 5.00, date: Date()),
        Transaction(title: "Bananas", type: .income, amount: 10.00, date: Date()),
    ]
    @State private var showAddTransactionView: Bool = false
    @State private var transaction: Transaction?
    @State private var transactionToEdit: Transaction?
    
    private var expense: String {
        let sumExpense: Double = transactions.filter({$0.type == .expense}).reduce(0, {$0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumExpense as NSNumber) ?? "$0.00"
    }
    
    private var income: String {
        let sumIncome: Double = transactions.filter({$0.type == .income}).reduce(0, {$0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "$0.00"
    }

    private var total: String {
        let sumExpense: Double = transactions.filter({$0.type == .expense}).reduce(0, {$0 + $1.amount})
        let sumIncome: Double = transactions.filter({$0.type == .income}).reduce(0, {$0 + $1.amount})
        var total: Double = sumIncome - sumExpense
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "$0.00"
    }
    
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
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(total)")
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
                        Text("\(expense)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("\(income)")
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
                        .onDelete(perform: delete)
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
    
    func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
        
    }
}

#Preview {
    HomeView()
}
