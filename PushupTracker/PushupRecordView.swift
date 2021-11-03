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
    
    private struct Constants {
        static let richardCellPhone = "801-360-1066"
    }
    
    var body: some View {
        NavigationView {
            Form {
                totalBody
                missionBody
                individualWorkoutsBody
                
            }
            .navigationBarTitle(Text("Pushup Tracker"))
            .navigationBarItems(trailing: Button(action: {
                showAddWorkoutModal = true
            }, label: {
                Image(systemName: "plus")
            }))
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
                ForEach(pushupViewModel.pushupTallies) { pushupTally in
                    HStack {
                        Text("\(PushupDateFormatter.shared.dateFormatter.string(from: pushupTally.date))")
                        Spacer()
                        Text("\(pushupTally.count)")
                    }
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
    
    var missionBody: some View {
        Section(header: Text("The Mission and Goal")) {
            Text("""
                Do 100,000 pushups for Kyle before November 10th. \
            Contact Richard at (richlamx@hotmail.com) or 801-360-1066.
            """)
                
        }
    }
}

struct PushupRecordView_Previews: PreviewProvider {
    static var previews: some View {
        PushupRecordView(pushupViewModel: PushupViewModel())
    }
}
