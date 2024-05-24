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
    let curOfficialRate: Double

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

