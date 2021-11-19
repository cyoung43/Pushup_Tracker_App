//
//  WorkoutHistory.swift
//  PushupTracker
//
//  Created by Chris Young on 11/18/21.
//

import Foundation


struct PushupTallyHistory {
    
    // MARK: - Properties
    var pushupTallies: [PushupTally] = []
    
    // MARK: - Init
    init() {
        if let jsonData = UserDefaults.standard.object(forKey: Key.tallies) as? Data {
            if let tallies = try? JSONDecoder().decode([PushupTally].self, from: jsonData) {
                pushupTallies = tallies.sorted(by: compareByDate)
            }
        }
    }
    
    // MARK: - CRUD Ops
    mutating func addPushupTally(_ pushupTally: PushupTally) {
        pushupTallies.append(pushupTally)
        pushupTallies.sort(by: compareByDate)
    }
    
    mutating func remove(at index: Int) {
        if index >= 0 && index < pushupTallies.count {
            pushupTallies.remove(at: index)
        }
    }
    
    mutating func removePushupTally(_ pushupTally: PushupTally) {
        if let index = pushupTallies.firstIndex(where: { pushupTally.id == $0.id }) {
            pushupTallies.remove(at: index)
        }
    }
    
    mutating func update(_ count: Int, for tally: PushupTally) {
        if let index = pushupTallies.firstIndex(where: { tally.id == $0.id }) {
            pushupTallies[index].count = count
        }
    }
    
    func save() {
        if let jsonData = try? JSONEncoder().encode(pushupTallies) {
            UserDefaults.standard.set(jsonData, forKey: Key.tallies)
        }
    }
    
    // MARK: - Helpers
    private func compareByDate(_ tally: PushupTally, _ otherTally: PushupTally) -> Bool {
        tally.date < otherTally.date
    }
    
    private struct Key {
        static let tallies = "tallies"
    }
}
