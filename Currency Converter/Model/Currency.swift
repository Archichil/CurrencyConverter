//
//  Currency.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 24.05.24.
//

import SwiftUI

struct Currency: Codable, Identifiable {
    let curID: Int
    let date: String
    let curAbbreviation: String
    let curScale: Int
    let curName: String
    var curOfficialRate: Double

    enum CodingKeys: String, CodingKey {
        case curID = "Cur_ID"
        case date = "Date"
        case curAbbreviation = "Cur_Abbreviation"
        case curScale = "Cur_Scale"
        case curName = "Cur_Name"
        case curOfficialRate = "Cur_OfficialRate"
    }
    
    var id: Int {
            return curID
        }
}

var currencies: [String] = ["AUD", "AMD", "BGN", "BRL", "BYN", "UAH", "DKK", "AED", "USD", "VND", "EUR", "PLN", "JPY", "INR", "IRR", "ISK", "CAD", "CNY", "KWD", "MDL", "NZD", "NOK", "RUB", "XDR", "SGD", "KGS", "KZT", "TRY", "GBP", "CZK", "SEK", "CHF"]


var currenciesFull: [String] = [
    "AUD (Австралийский доллар)",
    "AMD (Армянский драм)",
    "BGN (Болгарский лев)",
    "BRL (Бразильский реал)",
    "BYN (Белорусский рубль)",
    "UAH (Украинская гривна)",
    "DKK (Датская крона)",
    "AED (Дирхам ОАЭ)",
    "USD (Доллар США)",
    "VND (Вьетнамский донг)",
    "EUR (Евро)",
    "PLN (Польский злотый)",
    "JPY (Японская йена)",
    "INR (Индийская рупия)",
    "IRR (Иранский риал)",
    "ISK (Исландская крона)",
    "CAD (Канадский доллар)",
    "CNY (Китайский юань)",
    "KWD (Кувейтский динар)",
    "MDL (Молдавский лей)",
    "NZD (Новозеландский доллар)",
    "NOK (Норвежская крона)",
    "RUB (Российский рубль)",
    "XDR (Специальные права заимствования)",
    "SGD (Сингапурский доллар)",
    "KGS (Киргизский сом)",
    "KZT (Казахский тенге)",
    "TRY (Турецкая лира)",
    "GBP (Фунт стерлингов)",
    "CZK (Чешская крона)",
    "SEK (Шведская крона)",
    "CHF (Швейцарский франк)"
]
