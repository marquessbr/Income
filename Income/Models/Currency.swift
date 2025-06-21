
//
//  Untitled.swift
//  Income
//
//  Created by Armando Marques da Silva Sobrinho on 18/06/25.
//

import Foundation

enum Currency: Int, CaseIterable {
    case usd, pounds, brl
    
    var title: String {
        switch self {
        case .usd:
            return "USD"
        case .pounds:
            return "Pounds"
        case .brl:
            return "BRL"
        }
    }
    
    var locale: Locale {
        switch self {
        case .usd:
            return Locale(identifier: "en_US")
        case .pounds:
            return Locale(identifier: "en_GB")
        case .brl:
            return Locale(identifier: "pt_BR")
        }
    }
}
