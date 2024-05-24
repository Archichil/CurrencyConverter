//
//  ContentView.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 24.05.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
           HomeView()
                .navigationTitle("Currency Rates")
                .preferredColorScheme(.dark)
        }
//        HomeView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
