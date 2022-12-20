//
//  SliderWithColorThumb.swift
//  GuessTheSliderValue
//
//  Created by Руслан Шигапов on 20.12.2022.
//

import SwiftUI

struct SliderWithColorThumb: UIViewRepresentable {
    @Binding var value: Double
    @Binding var alpha: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueDidChanged),
            for: .valueChanged
        )
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
        uiView.thumbTintColor = .red.withAlphaComponent(alpha)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
}

extension SliderWithColorThumb {
    class Coordinator: NSObject {
        @Binding var value: Double
        
        init(value: Binding<Double>) {
            self._value = value
        }
        
        @objc func valueDidChanged(_ sender: UISlider) {
            value = Double(sender.value)
        }
    }
}

struct SliderWithColorThumb_Previews: PreviewProvider {
    static var previews: some View {
        SliderWithColorThumb(value: .constant(50), alpha: .constant(1))
    }
}
