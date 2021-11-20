//
//  DatabaseHelper.swift
//  PushupTracker
//
//  Created by Chris Young on 11/19/21.
//

import Foundation
import GRDB

class DatabaseHelper {
    // MARK: - Constants
    typealias WorkoutTable = WorkoutReport.Table
    
    struct Constant {
        static let fileName = "pushups.1"
        static let fileExtension = "sqlite"
    }
    
    // MARK: - Properties
    var dbQueue: DatabaseQueue
    
    // MARK: - Singleton
    static let shared = DatabaseHelper()
    
    private init() {
        if let directoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            let fileUrl = directoryUrl
                .appendingPathComponent(Constant.fileName)
                .appendingPathExtension(Constant.fileExtension)
            let fileExists = FileManager.default.fileExists(atPath: fileUrl.path)
            
            if let queue = try? DatabaseQueue(path: fileUrl.path) {
                dbQueue = queue
                
                if !fileExists {
                    createWorkoutReportTable()
                }
                return
            }
        }
        
        fatalError("Unable to connect to database")
    }
    
    // MARK: - Helpers
    private func createWorkoutReportTable() {
        // TO DO
        try? dbQueue.write { db in
            try? db.execute(sql: """
                            CREATE TABLE \(WorkoutTable.databaseTableName) (
                                \(WorkoutTable.id) TEXT PRIMARY KEY,
                                \(WorkoutTable.date) TEXT,
                                \(WorkoutTable.count) INTEGER)
                            """)
            
//            try? db.execute(sql: """
//                            INSERT INTO workoutReport VALUES (
//                                ?,
//                                '',
//                                3,
//                                '')
//                            """, arguments: [UUID()])
        }
    }
    
    // MARK: - CRUD Ops
    func deleteWorkoutReport(_ record: WorkoutReport) {
        do {
            try dbQueue.write { db in
                _ = try record.delete(db)
            }
        }
        catch {
            print("Error deleting record: \(error)")
        }
    }
    
    func saveWorkoutReport(_ record: WorkoutReport) {
        try? dbQueue.write { db in
            try? record.insert(db)
        }
    }
    
    func updateWorkoutReport(_ record: WorkoutReport) {
        try? dbQueue.write { db in
            try? record.update(db)
        }
    }
    
    func workoutRecords() -> [WorkoutReport] {
        do {
            let records = try dbQueue.inDatabase { (db: Database) -> [WorkoutReport] in
                var records = [WorkoutReport]()
                
//                let rows = try Row.fetchCursor(db, sql: "select * from \(WorkoutTable.databaseTableName)")
                let rows = try Row.fetchCursor(db, sql: """
                                                    select * from \(WorkoutTable.databaseTableName)
                                                    order by \(WorkoutTable.date) desc
                                                    """)
                
                while let row = try rows.next() {
                    records.append(WorkoutReport(row: row))
                }
            
                return records
            }
            
            return records
        }
        catch {
            return []
        }
    }
}
