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

var currenciesFull: [String: String] = [
    "AUD": "AUD (Австралийский доллар)",
    "AMD": "AMD (Армянский драм)",
    "BGN": "BGN (Болгарский лев)",
    "BRL": "BRL (Бразильский реал)",
    "BYN": "BYN (Белорусский рубль)",
    "UAH": "UAH (Украинская гривна)",
    "DKK": "DKK (Датская крона)",
    "AED": "AED (Дирхам ОАЭ)",
    "USD": "USD (Доллар США)",
    "VND": "VND (Вьетнамский донг)",
    "EUR": "EUR (Евро)",
    "PLN": "PLN (Польский злотый)",
    "JPY": "JPY (Японская йена)",
    "INR": "INR (Индийская рупия)",
    "IRR": "IRR (Иранский риал)",
    "ISK": "ISK (Исландская крона)",
    "CAD": "CAD (Канадский доллар)",
    "CNY": "CNY (Китайский юань)",
    "KWD": "KWD (Кувейтский динар)",
    "MDL": "MDL (Молдавский лей)",
    "NZD": "NZD (Новозеландский доллар)",
    "NOK": "NOK (Норвежская крона)",
    "RUB": "RUB (Российский рубль)",
    "XDR": "XDR (Специальные права заимствования)",
    "SGD": "SGD (Сингапурский доллар)",
    "KGS": "KGS (Киргизский сом)",
    "KZT": "KZT (Казахский тенге)",
    "TRY": "TRY (Турецкая лира)",
    "GBP": "GBP (Фунт стерлингов)",
    "CZK": "CZK (Чешская крона)",
    "SEK": "SEK (Шведская крона)",
    "CHF": "CHF (Швейцарский франк)"
]
