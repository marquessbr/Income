//
//  TransactionModel.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 09/06/25.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
    var displayDate: String {
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    var displayAmount: String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .currency
        numberFormat.maximumFractionDigits = 2
        return numberFormat.string(from: amount as NSNumber) ?? ""
    }
}
