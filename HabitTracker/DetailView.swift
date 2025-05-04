//
//  DetailView.swift
//  HabitTracker
//
//  Created by student on 03.05.25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingAlert: Bool = false
    @State private var showingEditView: Bool = false
    @Binding var activities: Activities
    var activity: Activity
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 16) {
                    CardView(caption: "I WANT TO", content: activity.name)
                    
                    CardView(caption: "WHEN?", content: activity.when)
                    
                    CardView(caption: "WHY?", content: activity.why)
                    
                    CardView(caption: "TIMES COMPLETED", content: "\(activity.timesCompleted) times")
                    
                    Button("Delete Habit",systemImage: "trash", role: .destructive) {
                        showingAlert = true
                    }
                    .padding(.vertical, 12)
                }
            }
        }
        .alert("Are you sure you want to delete this activity?", isPresented: $showingAlert, actions: {
            Button("Delete", role: .destructive) {
                if let idx = activities.list.firstIndex(of: activity) {
                    activities.list.remove(at: idx)
                    dismiss()
                }
            }
            Button("Cancel", role: .cancel) {
                showingAlert = false
            }
        })
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingEditView) {
            EditView(activities: $activities, activity: activity)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit Habit", systemImage: "square.and.pencil") {
                    showingEditView = true
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    var copiedActivity = activity
                    copiedActivity.timesCompleted += 1
                    if let idx = activities.list.firstIndex(of: activity) {
                        activities.list[idx] = copiedActivity
                    }
                } label: {
                    Text("+1 Completed")
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    //    DetailView(activity: $activity)
}

struct CardView: View {
    var caption: String
    var content: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(caption)
                    .font(.caption.weight(.thin))
                Text(content)
                    .font(.title.bold())
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 24)
        }
        .padding(.horizontal, 24)
    }
}
