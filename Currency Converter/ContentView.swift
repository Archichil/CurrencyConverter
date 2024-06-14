//
//  ContentView.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 24.05.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Currency Rates")
                }
            
            ConverterView()
                .tabItem {
                    Image(systemName: "sum")
                    Text("Calculator")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
