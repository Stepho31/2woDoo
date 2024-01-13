//
//  AddTaskButton.swift
//  2DO (To-do List App)
//
//  Created by Stephen Byron on 1/9/24.
//

import SwiftUI

struct AddTaskButton: View {
    var action: () -> Void
    
    let brownColor = Color(red: 139 / 255, green: 69 / 255, blue: 19 / 255)
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(brownColor)
        }
    }
}
