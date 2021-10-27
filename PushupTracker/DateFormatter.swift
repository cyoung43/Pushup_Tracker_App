//
//  DateFormatter.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import Foundation


class PushupDateFormatter {
    
    let dateFormatter: DateFormatter
    
    private init() {
        // TO DO
        dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
    }
    
    static let shared: PushupDateFormatter = {
       PushupDateFormatter()
    }()
}
