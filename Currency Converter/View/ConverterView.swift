//
//  ConverterView.swift
//  Currency Converter
//
//  Created by Артур Кухоцковолец on 25.05.24.
//

import SwiftUI

struct ConverterView: View {
    @StateObject var viewModel = FetchData()
    @State var itemSelectedFrom = "BYN"
    @State var itemSelectedTo = "USD"
    @State var amount: String = ""
    @State var result: String = ""
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert a currency")) {
                    TextField("Enter an amount", text: $amount)
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                        .onChange(of: amount) { newValue in
                            convertAmount()
                        }
                    
                    Picker(selection: $itemSelectedFrom, label: Text("From")) {
                        ForEach(currenciesFull.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            Text(value).tag(key)
                        }
                    }
                    .onChange(of: itemSelectedFrom) { newValue in
                        convertAmount()
                    }
                    
                    Picker(selection: $itemSelectedTo, label: Text("To")) {
                        ForEach(currenciesFull.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                            Text(value).tag(key)
                        }
                    }
                    .onChange(of: itemSelectedTo) { newValue in
                        convertAmount()
                    }
                }
                
                Section(header: Text("Conversion")) {
                    if Double(result) != nil {
                        Text("\(result) \(itemSelectedTo)")
                    } else {
                        Text(result)
                    }
                }
            }
            .navigationBarTitle("Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
        }
    }
    
    func convertAmount() {
        if itemSelectedTo == itemSelectedFrom {
            result = "Choose different currencies"
            return
        }
        
        if let amount = Double(amount),
           let convertedAmount = viewModel.convert(amount: amount, from: itemSelectedFrom, to: itemSelectedTo) {
            result = String(format: "%.3f", convertedAmount)
        } else {
            result = "-- \(itemSelectedTo)"
        }
    }
}

struct ConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterView()
    }
}
