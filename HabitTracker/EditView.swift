//
//  EditView.swift
//  HabitTracker
//
//  Created by student on 03.05.25.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var activities: Activities
    private var activity: Activity

    @State private var name: String
    @State private var when: String
    @State private var why: String
    @State private var timesCompleted: Int

    init(activities: Binding<Activities>,
       activity: Activity) {
        self._activities  = activities
        self.activity = activity

        self.name = activity.name
        self.when = activity.when
        self.why = activity.why
        self.timesCompleted = activity.timesCompleted
    }
    
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
                    TextField("Because I want to get jacked", text: $why)
                }
                Section("Times Completed") {
                    Stepper("\(timesCompleted) times", value: $timesCompleted, in: 0...Int.max)
                }
            }
            .navigationTitle("Edit Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let editedActivity = Activity(name: name, when: when, why: why, timesCompleted: activity.timesCompleted)
                        if let idx = activities.list.firstIndex(of: activity) {
                            activities.list[idx] = editedActivity
                        }
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
            .navigationTitle("Edit Habit")
        }
    }
}
