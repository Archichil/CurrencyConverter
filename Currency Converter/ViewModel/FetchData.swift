//
//  FetchData.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 24.05.24.
//

import SwiftUI

class FetchData: ObservableObject {
    @Published var conversionData: [Currency] = []
    
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
                
                // Декодирование данных
                do {
                    let currencies = try JSONDecoder().decode([Currency].self, from: data)
                    // Обработка данных на главном потоке
                    DispatchQueue.main.async {
                        // Пример: обновление UI
                        self.conversionData = currencies
                    }
                } catch {
                    print("Ошибка при декодировании JSON: \(error)")
                }
            }.resume()
        }
    }
    
}
