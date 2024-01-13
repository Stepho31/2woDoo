//
//  AddButtonStyle.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/9/24.
//

import SwiftUI

struct AddButtonStyle: ButtonStyle {
    
    let brownColor = Color(red: 139 / 255, green: 69 / 255, blue: 19 / 255)
    let tanColor = Color(red: 210 / 255, green: 180 / 255, blue: 140 / 255)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(brownColor)
            .foregroundColor(tanColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
    
}
