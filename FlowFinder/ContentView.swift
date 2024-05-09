//
//  ContentView.swift
//  FlowFinder
//
//  Created by James Fishwick on 5/9/24.
//

import SwiftUI

struct ContentView: View {
    private let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    @State private var inputAmount = ""
    @State private var startUnit = 0
    @State private var endUnit = 1
    
    private var convertedValue: Double {
            let unitToConvert = Measurement(value: Double(inputAmount) ?? 0, unit: units[startUnit])
            return unitToConvert.converted(to: units[endUnit]).value
        }
    
    var body: some View {
        NavigationStack {
            Form{
                Section("What are you converting from?") {
                    
                    TextField("Enter Amount:", text: $inputAmount)
                                               .keyboardType(.decimalPad)
                                        Picker("Starting Unit", selection: $startUnit) {
                                            ForEach(0..<units.count, id: \.self) {
                                                Text(self.units[$0].symbol)
                                            }
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                }
                Section("What unit are you converting to?") {
                    
                    Picker("End Unit", selection: $endUnit) {
                                            ForEach(0..<units.count, id: \.self) {
                                                Text(self.units[$0].symbol)
                                            }
                                        }.pickerStyle(.segmented)
                    Text("\(convertedValue, specifier: "%.4g")")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
