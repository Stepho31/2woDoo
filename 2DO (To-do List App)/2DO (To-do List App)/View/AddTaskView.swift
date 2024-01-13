//
//  AddTaskView.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/8/24.
//

import SwiftUI
import Combine

struct AddTaskView: View {
    @ObservedObject var taskStore: TaskStore
    @Binding var newTask: String
    @Binding var isShowing: Bool
    @State private var taskDate = Date()
    @State private var showDatePicker = true
    
    let brownColor = Color(red: 139 / 255, green: 69 / 255, blue: 19 / 255)
    let tanColor = Color(red: 210 / 255, green: 180 / 255, blue: 140 / 255)
    let tanUIColor = UIColor(red: 210 / 255, green: 180 / 255, blue: 140 / 255, alpha: 1)
    let lightGrayUIColor = UIColor.lightGray
    let placeholderUIColor = UIColor.white
    
    var body: some View {
        Spacer()
        VStack {
            Spacer()
            Text("New Task?")
                .font(.title)
                .foregroundColor(brownColor)
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(brownColor)
                    .frame(height: 36)
                
                CustomTextField(placeholder: "Enter a task name", text: $newTask, placeholderColor: placeholderUIColor, textColor: tanUIColor,
                                onCommit: {
                    dismissKeyboard()
                })
                .frame(height: 36)
                .padding(.horizontal, 10)
            }
            .padding()
            
            DatePicker("Task Time", selection: $taskDate, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(CompactDatePickerStyle())
                .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                .background(RoundedRectangle(cornerRadius: 8).fill(brownColor))
                .foregroundColor(tanColor)
                .frame(height: 36)
                .labelsHidden()
                .onReceive(Just(taskDate)) { newValue in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showDatePicker.toggle()  // Hide the DatePicker
                    }
                }
            
            
            Button("Add Task") {
                let trimmedTaskName = newTask.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmedTaskName.isEmpty else { return }
                taskStore.addTask(trimmedTaskName, scheduledTime: taskDate)
                newTask = ""
                isShowing = false
            }
            .buttonStyle(AddButtonStyle())
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 210 / 255, green: 180 / 255, blue: 140 / 255))
        .edgesIgnoringSafeArea(.all)
    }
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
