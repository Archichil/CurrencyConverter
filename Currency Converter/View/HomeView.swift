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
        
        VStack {
            if !viewModel.conversionData.isEmpty {
                ScrollView{
                    
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
        print(String(scalar))
        return String(scalar)
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
