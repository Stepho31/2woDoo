//
//  InstructionalView.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/13/24.
//

import SwiftUI

struct CompactInstructionalView: View {
    @Binding var hasSeenInstructions: Bool
    @State private var instructionStep = 0
    
    let brownColor = Color(red: 139 / 255, green: 69 / 255, blue: 19 / 255)
    let tanColor = Color(red: 210 / 255, green: 180 / 255, blue: 140 / 255)

    let instructions = [
        "Tap the '+' to add tasks.",
        "Enter task details like name, time, and date.",
        "Submit to see your task on the dashboard.",
        "Mark tasks as completed with a tap."
    ]

    var body: some View {
        VStack(spacing: 10) {
             Text("Instructions")
            .font(.title2)
            .fontWeight(.medium)
            .foregroundColor(tanColor)
            .padding(.bottom, 5)
            
            ForEach(0..<instructions.count, id: \.self) { index in
                           if index == instructionStep {
                               Text(instructions[index])
                                   .multilineTextAlignment(.center)
                                   .padding([.horizontal])
                                   .transition(.opacity)
                           }
                       }
            .frame(height: 100)
            HStack {
                if instructionStep > 0 {
                    Button(action: {
                        withAnimation { instructionStep -= 1 }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .foregroundColor(tanColor)
                    }
                }
                Spacer()
                if instructionStep < instructions.count - 1 {
                    Button(action: {
                        withAnimation { instructionStep += 1 }
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(tanColor)
                    }
                } else {
                    Button("Got it!") {
                        hasSeenInstructions = true
                    }
                    .buttonStyle(AddButtonStyle())
                }
            }
            .padding()
        }
        .frame(width: 300, height: 250)
        .background(brownColor)
        .cornerRadius(15)
        .padding()
        .shadow(radius: 5)
    }
}
