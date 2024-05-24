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
        guard var baseRate = self.conversionData.first(where: { $0.curAbbreviation == baseCurrency }) else {
            // Базовая валюта не найдена в данных
            return
        }
        
        var currencyRate = baseRate.curOfficialRate / Double(baseRate.curScale)
        
        // Обновляем курсы для остальных валют в массиве
        for i in 0..<self.conversionData.count {
            // Пропускаем базовую валюту
//            guard self.conversionData[i].curAbbreviation != baseCurrency else {
//                return
//            }
            
            // Вычисляем относительное значение курса для текущей валюты
            let relativeRate = (self.conversionData[i].curOfficialRate / Double(self.conversionData[i].curScale)) / currencyRate * Double(self.conversionData[i].curScale)
            
            // Перезаписываем значение курса для текущей валюты в массиве
            self.conversionData[i].curOfficialRate = relativeRate
        }
    }
}
