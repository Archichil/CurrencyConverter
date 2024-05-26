//
//  HomeView.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 24.05.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = FetchData()
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.conversionData.isEmpty {
                    ScrollView{
                        Text(getDate(dateString: viewModel.conversionData.first!.date))
                        
                        LazyVStack(alignment: .leading, spacing: 15, content: {
                            ForEach(viewModel.conversionData){ currency in
                                HStack(spacing: 15){
                                    
                                    Text(GetFlag(abbr: currency.curAbbreviation))
                                        .font(.system(size: 55))
                                    
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        Text("\(currency.curScale) \(currency.curName) (\(currency.curAbbreviation))")
                                            .font(.system(size: 20))
                                            .fontWeight(.bold)
                                        
                                        Text("\(currency.curOfficialRate) \(viewModel.baseCurrency)")
                                            .fontWeight(.heavy)
                                    })
                                }
                                .padding(.horizontal)
                            }
                        })
                        .padding(.top)
                    }
                } else {
                    ProgressView()
                }
            }
            .toolbar(content: {
                Menu(viewModel.baseCurrency, content: {
                    ForEach(currenciesFull.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                        Button(action: { viewModel.updateRelativeRates(baseCurrency: key) }, label: {
                            Text(value)
                        })
                    }
                })
            })
            .navigationTitle("Currency Rates")
        }
    }
    
    
    func GetFlag(abbr currencyAbbr: String) -> String {
        if currencyAbbr == "XDR" {return ""}
        
        let base = 127397
        var code = currencyAbbr
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()

        for scalarValue in code.unicodeScalars {
            guard let flagScalar = UnicodeScalar(base + Int(exactly: scalarValue.value)!) else {
                return ""
            }
            scalar.append(flagScalar)
        }
        return String(scalar)
    }
    
    func getDate(dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        inputDateFormatter.locale = Locale(identifier: "ru-RU")

        if let date = inputDateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateStyle = .medium
            outputDateFormatter.timeStyle = .medium
            outputDateFormatter.locale = Locale(identifier: "ru-RU")
            outputDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

            let dateStr = outputDateFormatter.string(from: date)
            return "Последнее обновление курса НБРБ:\n\(dateStr)"
        } else {
            return "Последнее обновление курса НБРБ: Неизвестно"
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
