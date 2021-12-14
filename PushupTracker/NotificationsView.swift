//
//  NotificationsView.swift
//  PushupTracker
//
//  Created by Chris Young on 12/13/21.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notificationsAllowed = false
    @State private var selectedDate = Date()
    @State private var selectedDays = [false, true, false, true, false, true, false]
    
    var body: some View {
        Form {
            WeekDayPicker(selectedDays: $selectedDays)
            DatePicker("Work out at", selection: $selectedDate, displayedComponents: .hourAndMinute)
            Button("Update Notification Schedule") {
                let center = UNUserNotificationCenter.current()
                
                center.removeAllPendingNotificationRequests()
                
                if notificationsAllowed {
                    selectedDays.indices.forEach { dayIndex in
                        if selectedDays[dayIndex] {
                            let content = UNMutableNotificationContent()
                            content.title = "Time for your workout"
                            content.body = "Remember your goals! \(Date.weekdays()[dayIndex])s at \(selectedDate.time)"
                            content.sound = UNNotificationSound.default

                            var date = DateComponents()
                            let calendar = Calendar.current

                            date.hour = calendar.component(.hour, from: selectedDate)
                            date.minute = calendar.component(.minute, from: selectedDate)
                            date.weekday = dayIndex + 1
                            
                            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            UNUserNotificationCenter.current().add(request)
                        }
                    }
                }
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .provisional]) { success, error in
                if success {
                    notificationsAllowed = true
                }
                else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

extension Date {
    var time: String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mma"
        
        return formatter.string(from: self)
    }
    
    static func weekdays() -> [String] {
        DateFormatter().weekdaySymbols
    }
}
