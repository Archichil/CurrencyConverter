//
//  FetchData.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 24.05.24.
//

import SwiftUI

class FetchData: ObservableObject {
    @Published var conversionData: [Currency] = []
    @Published var baseCurrency: String = "BYN"
    
    init() {
        fetch()
    }
    
    func fetch(){
        
        let urlString = "https://api.nbrb.by/exrates/rates?periodicity=0"
        
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Ошибка запроса: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("Нет данных в ответе")
                    return
                }
                
                do {
                    let currencies = try JSONDecoder().decode([Currency].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.conversionData = currencies
                    }
                } catch {
                    print("Ошибка при декодировании JSON: \(error)")
                }
            }.resume()
        }
    }
    
    func updateRelativeRates(baseCurrency: String) {
        
        self.baseCurrency = baseCurrency
        if baseCurrency == "BYN" {fetch()}
        // Найдем курс базовой валюты
        guard let baseRate = self.conversionData.first(where: { $0.curAbbreviation == baseCurrency }) else {
            // Базовая валюта не найдена в данных
            return
        }
        
        let currencyRate = baseRate.curOfficialRate / Double(baseRate.curScale)
        
        // Обновляем курсы для остальных валют в массиве
        for i in 0..<self.conversionData.count {
            
            // Вычисляем относительное значение курса для текущей валюты
            let relativeRate = (self.conversionData[i].curOfficialRate / Double(self.conversionData[i].curScale)) / currencyRate * Double(self.conversionData[i].curScale)
            
            // Перезаписываем значение курса для текущей валюты в массиве
            self.conversionData[i].curOfficialRate = relativeRate
        }
    }
    
    func convert(amount: Double, from fromCurrency: String, to toCurrency: String) -> Double? {
            if fromCurrency == baseCurrency {
                guard let toRate = conversionData.first(where: { $0.curAbbreviation == toCurrency }) else {
                    return nil
                }
                let convertedAmount = (amount / toRate.curOfficialRate) * Double(toRate.curScale)
                return convertedAmount
            } else if toCurrency == baseCurrency {
                guard let fromRate = conversionData.first(where: { $0.curAbbreviation == fromCurrency }) else {
                    return nil
                }
                let amountInBaseCurrency = (amount / Double(fromRate.curScale)) * fromRate.curOfficialRate
                return amountInBaseCurrency
            } else {
                return nil
            }
        }
}
