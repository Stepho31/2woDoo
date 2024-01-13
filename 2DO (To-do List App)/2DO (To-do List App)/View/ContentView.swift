//
//  ContentView.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasSeenInstructions") private var hasSeenInstructions = false
    
    @StateObject private var taskStore = TaskStore()
    
    @State private var newTask = ""
    
    @State private var isShowingAddTaskSheet = false
    @State private var showCongratsAnimation = false
    @State private var showFeedbackPopup = false
    @State private var feedbackGiven = false
    
    @State private var animationAmount = 0.0
    
    let brownColor = Color(red: 139 / 255, green: 69 / 255, blue: 19 / 255)
    let tanColor = Color(red: 210 / 255, green: 180 / 255, blue: 140 / 255)
    
    var body: some View {
        NavigationView {
            ZStack {
                tanColor.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(taskStore.sortedTasks(), id: \.id) { task in
                            TaskCardView(task: task,
                                         toggleCompletion: {
                                taskStore.toggleTaskCompletion(task)
                                checkIfAllTasksCompleted()
                            },
                                         deleteAction: {
                                if let index = taskStore.tasks.firstIndex(where: { $0.id == task.id }) {
                                    taskStore.tasks.remove(at: index)
                                }
                            })
                        }
                    }
                    .padding()
                }
                
                if showCongratsAnimation {
                    Text("Congratulations! You've completed all of your tasks!")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(brownColor)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(15)
                        .scaleEffect(1 + animationAmount / 10)
                        .opacity(1 - animationAmount / 10)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animationAmount)
                        .onAppear {
                            animationAmount = 1
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                showCongratsAnimation = false
                                animationAmount = 0
                                taskStore.tasks.removeAll()
                            }
                        }
                        .onDisappear {
                            if !feedbackGiven {
                                showFeedbackPopup = true
                            }
                        }
                }
                if !hasSeenInstructions {
                    CompactInstructionalView(hasSeenInstructions: $hasSeenInstructions)
                        .transition(.slide)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("2DO")
                        .font(.title)
                        .foregroundColor(brownColor)
                }
            }
            .navigationBarItems(
                trailing: AddTaskButton {
                    isShowingAddTaskSheet = true
                }
            )
            .sheet(isPresented: $isShowingAddTaskSheet) {
                AddTaskView(taskStore: taskStore, newTask: $newTask, isShowing: $isShowingAddTaskSheet)
                    .background(tanColor)
            }
            .alert(isPresented: $showFeedbackPopup) {
                Alert(
                    title: Text("Feedback"),
                    message: Text("Would you like to provide feedback?"),
                    primaryButton: .default(Text("Yes"), action: {
                        feedbackGiven = true
                        sendFeedback()
                    }),
                    secondaryButton: .cancel(Text("Not Now"))
                )
            }
        }
    }
    
    private func checkIfAllTasksCompleted() {
        if taskStore.tasks.allSatisfy({ $0.isCompleted }) {
            showCongratsAnimation = true
        }
    }
    private func sendFeedback() {
        let email = "stephenbyron31@gmail.com"
        let subject = "Feedback for 2DO App"
        let body = "Please write your feedback here..."
        
        if let url = URL(string: "mailto:\(email)?subject=\(subject)&body=\(body)") {
            UIApplication.shared.open(url)
        }
    }
}

