//
//  AddView.swift
//  HabitTracker
//
//  Created by student on 03.05.25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var when: String = ""
    @State private var why: String = ""
    @Binding var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                Section("I Want To") {
                    TextField("Exercise for 30 minutes", text: $name)
                }
                Section("When?") {
                    TextField("Everyday at 5:00 PM", text: $when)
                }
                Section("Why?") {
                    TextField("Because I want to...", text: $why)
                }
            }
            .navigationTitle("Add New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let newActivity = Activity(name: name, when: when, why: why, timesCompleted: 0)
                        activities.list.append(newActivity)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
