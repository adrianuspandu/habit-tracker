//
//  Activities.swift
//  HabitTracker
//
//  Created by student on 03.05.25.
//

import Foundation
import SwiftData

@Observable
class Activities {
    var list: [Activity] {
        didSet {
            if let data = try? JSONEncoder().encode(list) {
                UserDefaults.standard.set(data, forKey: "SavedActivities")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "SavedActivities") {
            if let savedActivities = try? JSONDecoder().decode([Activity].self, from: data) {
                list = savedActivities
                return
            }
        }
        
        list = []
    }
}
