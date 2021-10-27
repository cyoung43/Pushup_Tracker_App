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
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Total number of pushups:").bold()
                        Spacer()
                        Text("\(pushupViewModel.totalCount)")
                    }
                }
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
    }
}

struct PushupRecordView_Previews: PreviewProvider {
    static var previews: some View {
        PushupRecordView(pushupViewModel: PushupViewModel())
    }
}
