//
//  PushupViewModel.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import Foundation


class PushupViewModel: ObservableObject {
    private struct Key {
        static let tallies = "tallies"
        static let maxDailyPushupsForKyle = 50
    }
    
    @Published var pushupTallyHistory = PushupTallyHistory()
    
    // MARK: - User Intents
    
    var pushupTallies: [PushupTally] {
        pushupTallyHistory.pushupTallies
    }
    
    func append(_ pushupTally: PushupTally) {
        pushupTallyHistory.addPushupTally(pushupTally)
        pushupTallyHistory.save()
    }
    
    func removeTally(at index: Int) {
        pushupTallyHistory.remove(at: index)
        pushupTallyHistory.save()
    }
    
    func update(_ count: Int, for tally: PushupTally) {
        pushupTallyHistory.update(count, for: tally)
        pushupTallyHistory.save()
    }
    
    // MARK: - Model Access
    
    var totalCount: Int {
        pushupTallies.reduce(0) {
            $0 + $1.count
        }
    }
    
    var pushupsThatCount: Int {
        pushupTallies.reduce(0) { $0 + min($1.count, Key.maxDailyPushupsForKyle)}
    }
    
    // MARK: - Helpers
    
    func save() {
        let encoder = JSONEncoder()
        
        if let jsonData = try? encoder.encode(pushupTallies) {
            UserDefaults.standard.set(jsonData, forKey: Key.tallies)
        }
    }
}
