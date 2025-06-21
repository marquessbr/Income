//
//  TransactionModel.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 09/06/25.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
    
    var displayDate: String {
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    func displayAmount(currency: Currency) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .currency
        numberFormat.locale = currency.locale
        return numberFormat.string(from: amount as NSNumber) ?? ""
    }
}
