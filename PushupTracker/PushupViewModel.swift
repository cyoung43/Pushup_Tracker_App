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
    
    var workoutReports: [WorkoutReport] {
        DatabaseHelper.shared.workoutRecords()
    }
    
    func append(_ workoutReport: WorkoutReport) {
        DatabaseHelper.shared.saveWorkoutReport(workoutReport)
        objectWillChange.send()
    }
    
    func removeWorkout(at index: Int) {
        if index >= 0 && index < workoutReports.count {
            DatabaseHelper.shared.deleteWorkoutReport(workoutReports[index])
            objectWillChange.send()
        }
    }
    
    func update(_ count: Int, for workoutReport: WorkoutReport) {
        var updatedReport = workoutReport
        updatedReport.count = count
        DatabaseHelper.shared.updateWorkoutReport(updatedReport)
        objectWillChange.send()
    }
    
    // MARK: - Model Access
    
    var totalCount: Int {
        workoutReports.reduce(0) {
            $0 + $1.count
        }
    }
    
    var pushupsThatCount: Int {
        workoutReports.reduce(0) { $0 + min($1.count, Key.maxDailyPushupsForKyle)}
    }
}
