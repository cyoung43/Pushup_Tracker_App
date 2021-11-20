//
//  WorkoutReport.swift
//  PushupTracker
//
//  Created by Chria Younf on 11/17/21.
//

import Foundation
import GRDB

struct WorkoutReport: TableRecord, FetchableRecord, PersistableRecord, Identifiable {
    // MARK: - Constants
    
    struct Table {
        static let databaseTableName = "workoutReport"
        
        static let id = "id"
        static let count = "count"
        static let date = "date"
    }
    
    // MARK: - Properties
    
    var id: String
    var count: Int
    var date: String
    
    // MARK: - Init
    
    init(row: Row) {
        id = row[Table.id]
        count = row[Table.count]
        date = row[Table.date]
    }
    
    init(count: Int, date: Date) {
        id = UUID().uuidString
        self.count = count
        self.date = date.ISO8601Format()
    }
    
    // MARK: - Encodable Record
    func encode(to container: inout PersistenceContainer) {
        container[Table.id] = id
        container[Table.count] = count
        container[Table.date] = date
    }
}

extension WorkoutReport {
    var dateString: String {
        let databaseFormatter = ISO8601DateFormatter()
        
        if let dateObject = databaseFormatter.date(from: date) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            return dateFormatter.string(from: dateObject)
        }
        
        return "Unknown date"
    }
}
