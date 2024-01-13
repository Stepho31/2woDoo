//
//  TaskStore.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/8/24.
//

import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    init() {
        loadTasks()
    }
    
    func toggleTaskCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func addTask(_ taskName: String, scheduledTime: Date) {
         let task = Task(name: taskName, isCompleted: false, dateCreated: Date(), scheduledTime: scheduledTime)
        print("Created Task: \(task)")
         tasks.append(task)
     }
    
    func formatDate(_ date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateStyle = .short
         formatter.timeStyle = .short
         return formatter.string(from: date)
     }
    
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: "tasks") {
            if let decodedTasks = try? JSONDecoder().decode([Task].self, from: data) {
                tasks = decodedTasks
            }
        }
    }
    
    func saveTasks() {
        if let encodedData = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedData, forKey: "tasks")
        }
    }
    func sortedTasks() -> [Task] {
         tasks.sorted { $0.scheduledTime < $1.scheduledTime }
     }
}
