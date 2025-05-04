//
//  Activity.swift
//  HabitTracker
//
//  Created by student on 03.05.25.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var when: String
    var why: String
    var timesCompleted: Int
}
