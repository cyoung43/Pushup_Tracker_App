//
//  PushupTally.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import Foundation


struct PushupTally: Identifiable, Codable {
    var id = UUID()
    var count: Int
    var date: Date
}

extension PushupTally {
    var dateString: String {
        PushupDateFormatter.shared.dateFormatter.string(from: date)
    }
}


