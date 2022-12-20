//
//  ContentView.swift
//  GuessTheSliderValue
//
//  Created by Руслан Шигапов on 20.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var targetValue = Int.random(in: 50...100)
    @State private var currentValue: Double = 50
    @State private var alpha: Double = 1
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Подвиньте слайдер как можно ближе к: \(targetValue)")
            
            HStack {
                Text("0")
                SliderWithColorThumb(value: $currentValue, alpha: $alpha)
                    .onChange(of: currentValue) { _ in
                        computeAlpha()
                    }
                Text("100")
            }
            
            Button("Проверь меня!") {
                showAlert.toggle()
            }
            .alert("Your Score", isPresented: $showAlert, actions: {}) {
                Text("\(computeScore())")
            }
            
            Button("Начать заново") {
                targetValue = Int.random(in: 50...100)
                currentValue = 50
            }
        }
        .padding()
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
    
    private func computeAlpha() {
        alpha = Double(computeScore()) / 100
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
