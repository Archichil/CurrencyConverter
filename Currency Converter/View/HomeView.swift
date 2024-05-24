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
//        ScrollView {
//            LazyVStack(alignment: .leading, spacing: 15) {
//                ForEach(viewModel.conversionData) { currency in
//                    HStack(spacing: 15){
//                        Text(currency.curAbbreviation)
//                    }
//                    .padding(.horizontal)
//                    VStack(alignment: .leading) {
//                        Text("\(String(currency.curScale)) \(currency.curName)")
//                            .font(.headline)
//                        Text("Abbreviation: \(currency.curAbbreviation)")
//                            .font(.subheadline)
//                        Text("Rate: \(currency.curOfficialRate)")
//                            .font(.subheadline)
//                    }
//                    .padding()
//                    .background(Color(UIColor.secondarySystemBackground))
//                    .cornerRadius(10)
//                }
//            }
//            .padding()
//        }
        
        ScrollView{
            
            LazyVStack(alignment: .leading, spacing: 15, content: {
                ForEach(viewModel.conversionData){ currency in
                    HStack(spacing: 15){
                        
                        Text(GetFlag(abbr: currency.curAbbreviation))
                            .font(.system(size: 55))
                        
                        VStack(alignment: .leading, spacing: 5, content: {
                            Text("\(currency.curScale) \(currency.curAbbreviation)")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("\(currency.curOfficialRate) BYN")
                                .fontWeight(.heavy)
                        })
                    }
                    .padding(.horizontal)
                }
            })
            .padding(.top)
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
        print(String(scalar))
        return String(scalar)
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
