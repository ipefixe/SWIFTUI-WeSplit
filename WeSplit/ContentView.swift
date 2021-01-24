//
//  ContentView.swift
//  WeSplit
//
//  Created by Kevin Boulala on 22/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var indexOfNumberOfPeople = 0
    @State private var indexOfTipPercentage = 0
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var amountPlusTip: Double {
        let amount = Double(checkAmount) ?? 0
        let percentages = Double(tipPercentages[indexOfTipPercentage])
        let tipValue = amount * (percentages / 100)
        
        return amount + tipValue
    }
    
    var totalPerPerson: Double {
        let numberOfPeople = Double(indexOfNumberOfPeople + 2)
        
        return amountPlusTip / numberOfPeople
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $indexOfNumberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip", selection: $indexOfTipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total amount")) {
                    Text("$\(amountPlusTip, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
