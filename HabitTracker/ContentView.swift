//
//  ContentView.swift
//  HabitTracker
//
//  Created by student on 03.05.25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddView: Bool = false
    @State private var activities: Activities = Activities()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        
                        if activities.list.isEmpty {
                            Text("You don't have any habits yet. Add one by tapping the plus (+) button in the bottom right corner.")
                                .padding(40)
                        }
                        
                        ForEach(activities.list) { activity in
                                NavigationLink {
                                    DetailView(activities: $activities, activity: activity)
                                } label: {
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.white)
                                            .frame(width: UIScreen.main.bounds.width - 20, height: 80)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(activity.name)
                                                .font(.headline)
                                                
                                            Text(activity.when)
                                                .font(.caption)
                                            
                                        }
                                        .padding(.horizontal, 20)
                                    }
                                }
                                .foregroundStyle(.primary)
                            
                        }
                    }
                }
                .navigationTitle("Habit Tracker")
                .sheet(isPresented: $showingAddView) {
                    AddView(activities: $activities)
                }
            }
            .overlay(
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                    .padding(16),
                alignment: .bottomTrailing
            )
        }
    }
}

#Preview {
    ContentView()
}
