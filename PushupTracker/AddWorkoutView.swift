//
//  AddWorkoutView.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import SwiftUI

struct AddWorkoutView: View {
    @ObservedObject var pushupViewModel: PushupViewModel
    
    @State private var numberOfPushups = "50"
    @State private var date = Date()
    
    var onDismiss: () -> ()
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Number of Pushups").layoutPriority(100)
                    Spacer()
                    TextField("#", text: $numberOfPushups)
                        .keyboardType(.numbersAndPunctuation)
                        .multilineTextAlignment(.trailing)
                }
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("Date")
                }
            }
            .navigationBarTitle("Add Workout", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                onDismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                saveWorkout()
                onDismiss()
            }, label: {
                Text("Save")
            }))
        }
    }
    
    private func saveWorkout() {
        let number = numberOfPushups.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let pushupCount = Int(number) {
            if pushupCount > 0 {
                pushupViewModel.append(WorkoutReport(count: pushupCount, date: date))
            }
        }
    }
}

//struct AddWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWorkoutView()
//    }
//}
