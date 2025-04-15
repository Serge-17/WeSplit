//
//  ContentView.swift
//  WeSplit
//
//  Created by Serge Eliseev on 13.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPrecentages = [0, 10, 15, 20, 25]
    
    @FocusState private var amountIsFocused: Bool
    
    var totalcheck: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        return checkAmount + tipValue
        
    }
    
    var totalPerPerson: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        let grandTotal = checkAmount + tipValue
        let amountPresonal = grandTotal / (Double(numberOfPeople) + 2.0)
        
        return amountPresonal
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2..<16) {
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink)
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip precentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                    
                }
                
                Section("Total check") {
                    Text(totalcheck, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? Color.red : .primary)
                }
                

            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
 
        }
        
    
    }
}

#Preview {
    ContentView()
}
