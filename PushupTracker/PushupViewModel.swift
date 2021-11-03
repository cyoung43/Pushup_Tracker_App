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
    
    @Published var pushupTallies: [PushupTally] = []
    
    init() {
        if let jsonData = UserDefaults.standard.object(forKey: Key.tallies) as? Data {
            let decoder = JSONDecoder()
            
            // .self on type expression refers to the actual type
            if let tallies = try? decoder.decode([PushupTally].self, from: jsonData) {
                pushupTallies = tallies.sorted {
                    $0.date < $1.date
                }
            }
        }
    }
    
    // MARK: - User Intents
    
    func append(_ pushupTally: PushupTally) {
        pushupTallies.append(pushupTally)
        save()
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
