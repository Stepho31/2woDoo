//
//  TaskCardView.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/9/24.
//

import SwiftUI

struct TaskCardView: View {
    @StateObject private var taskStore = TaskStore()
    let task: Task
    var toggleCompletion: () -> Void
    var deleteAction: () -> Void
    
    @State private var offset: CGFloat = 0
    private let swipeThreshold: CGFloat = 50
    
    let tanColor = Color(red: 210 / 255, green: 180 / 255, blue: 140 / 255)
    let brownColor = Color(red: 139 / 255, green: 69 / 255, blue: 19 / 255)
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .leading) {
                    Text(task.name)
                        .fontWeight(.medium)
                        .foregroundColor(brownColor)
                        .onAppear {
                            print("Displaying Task: \(task.name)")
                        }
                    Text("Scheduled: \(task.scheduledTime.formatted())")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(tanColor)
                        .frame(width: 24, height: 24)
                    
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(task.isCompleted ? brownColor : .clear)
                        .frame(width: 24, height: 24)
                }
                .onTapGesture {
                    toggleCompletion()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding([.leading, .trailing], 10)
            .offset(x: self.offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width < 0 && abs(gesture.translation.width) > swipeThreshold {
                            self.offset = gesture.translation.width
                        }
                    }
                    .onEnded { _ in
                        if self.offset < -geometry.size.width * 0.5 {
                            deleteAction()
                        }
                        self.offset = 0
                    }
            )
        }
        .frame(height: 60)
    }
}
