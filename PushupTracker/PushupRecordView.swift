//
//  PushupRecordView.swift
//  PushupTracker
//
//  Created by New User on 10/27/21.
//

import SwiftUI

struct PushupRecordView: View {
    @ObservedObject var pushupViewModel: PushupViewModel
    @State private var showAddWorkoutModal = false
    @State private var showReportTotalModal = false
    @State private var editMode: EditMode = .inactive
    
    private struct Constants {
        static let richardCellPhone = "801-360-1066"
    }
    
    var body: some View {
        NavigationView {
            Form {
                totalBody
                individualWorkoutsBody
                
            }
            .navigationBarTitle(Text("Pushup Tracker"))
            .navigationBarItems(leading: Button(action: {
                showAddWorkoutModal = true
            }, label: {
                Image(systemName: "plus")
            }), trailing: EditButton())
            .environment(\.editMode, $editMode)
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showAddWorkoutModal) {
            AddWorkoutView(pushupViewModel: pushupViewModel, onDismiss: {
                showAddWorkoutModal = false
            })
        }
        .sheet(isPresented: $showReportTotalModal) {
            MessageComposeView(recipients: [Constants.richardCellPhone], body: "I've competed \(pushupViewModel.pushupsThatCount) pushups for Kyle") { messageSent in
                showReportTotalModal = false
            }
        }
    }
    
    var individualWorkoutsBody: some View {
        Section(header: Text("Individual Workouts")) {
            List {
                ForEach(pushupViewModel.workoutReports) { workoutReport in
                    HStack {
                        Text("\(workoutReport.dateString)")
                            .layoutPriority(1)
                        Spacer()
                        EditableText(text: "\(workoutReport.count)", isEditing: editMode.isEditing, textAlignment: .trailing) { updatedText in
                            if let count = Int(updatedText) {
                                pushupViewModel.update(count, for: workoutReport)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { pushupViewModel.removeWorkout(at: $0) }
                }
            }
        }
    }
    
    var totalBody: some View {
        Section {
            HStack {
                Text("Total number of pushups:").bold()
                Spacer()
                Text("\(pushupViewModel.totalCount)")
            }
            HStack {
                Text("Pushups that count for Kyle").bold()
                Spacer()
                Text("\(pushupViewModel.pushupsThatCount)")
            }
            Button {
                showReportTotalModal = true
            } label: {
                Label("Report", systemImage: "square.and.arrow.up")
            }
        }
    }
}

struct PushupRecordView_Previews: PreviewProvider {
    static var previews: some View {
        PushupRecordView(pushupViewModel: PushupViewModel())
    }
}
