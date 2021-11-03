//
//  HW7.swift
//  PushupTracker
//
//  Created by Chris Young on 10/27/21.
//

import SwiftUI

struct HW7: View {
    var body: some View {
        TabView {
            AlertView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Alert View")
                }
            DateView()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Date View")
                }
        }
    }
}

struct AlertView: View {
    @State private var showingAlertOne = false
    @State private var showingAlertTwo = false
    @State private var showingAlertThree = false
    @State private var showingAlertFour = false
    @State private var username = "username"
    @State private var password = "password"
    
    let alert = UIAlertController(title: "Login", message: "Enter your credentials", preferredStyle: .alert)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("General Alert")
                        Spacer()
                        Button(action: {
                            showingAlertOne = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                            .alert("IS 543", isPresented: $showingAlertOne) {
                                Button("Okay", role: .cancel) { }
                            }
                    }
                }
                Section {
                    HStack {
                        Text("Alert with multiple options")
                        Spacer()
                        Button(action: {
                            showingAlertTwo = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                            .alert("Multiple Options", isPresented: $showingAlertTwo) {
                                Button("Swift") { }
                                Button("SwiftUI") { }
                                Button("JavaScript") { }
                                Button("Cancel", role: .cancel) { }
                            }
                    }
                }
                Section {
                    HStack {
                        Text("Alert with destructive")
                        Spacer()
                        Button(action: {
                            showingAlertThree = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                            .alert("Destructive", isPresented: $showingAlertThree) {
                                Button("Delete", role: .destructive) { }
                                Button("Cancel", role: .cancel) { }
                            }
                    }
                }
                // I was trying to do an alert with like a login form here but couldn't quite figure it out.
                Section {
                    HStack {
                        Text("Alert with multiple/destructive")
                        Spacer()
                        Button(action: {
                            showingAlertFour = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                            .alert("Alert text field", isPresented: $showingAlertFour) {
                                Button("Option 1") { }
                                Button("Option 2") { }
                                Button("Option 3", role: .destructive) { }
                            }
                    }
                }
            }
            .navigationTitle("Alerts")
        }
    }
}

struct DateView: View {
    @State private var showingSheetOne = false
    @State private var showingSheetTwo = false
    @State private var showingSheetThree = false
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Wheel type")
                        Spacer()
                        Button(action: {
                            showingSheetOne = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                    }
                }
                .sheet(isPresented: $showingSheetOne) {
                    Text("Pick a date 📆")
                    DatePicker("Pick date", selection: $date)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                }
                Section {
                    HStack {
                        Text("Graphical type")
                        Spacer()
                        Button(action: {
                            showingSheetTwo = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                    }
                }
                .sheet(isPresented: $showingSheetTwo) {
                    Text("Pick a date 📆")
                    DatePicker("Pick date", selection: $date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .padding()
                }
                Section {
                    HStack {
                        Text("Compact type")
                        Spacer()
                        Button(action: {
                            showingSheetThree = true
                        }, label: {
                            Image(systemName: "chevron.right")
                        })
                    }
                }
                .sheet(isPresented: $showingSheetThree) {
                    Text("Pick a date 📆")
                    DatePicker("Pick date", selection: $date)
                        .datePickerStyle(CompactDatePickerStyle())
                        .labelsHidden()
                        .padding()
                }
            }
            .navigationTitle("Dates")
        }
    }
}

struct HW7_Previews: PreviewProvider {
    static var previews: some View {
        HW7()
    }
}
