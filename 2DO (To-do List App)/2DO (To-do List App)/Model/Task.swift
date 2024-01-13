//
//  Task.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/9/24.
//

import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
    var name: String
    var isCompleted = false
    var dateCreated = Date()
    var scheduledTime: Date
}
