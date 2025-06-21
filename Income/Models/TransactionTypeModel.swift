//
//  TransactionTypeModel.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 09/06/25.
//

import Foundation

enum TransactionType: Int, CaseIterable, Identifiable {
    case income, expense
    var id: Self {self}
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
