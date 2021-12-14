//
//  WeekDayPicker.swift
//  PushupTracker
//
//  Created by Chris Young on 12/13/21.
//

import SwiftUI

struct WeekDayPicker: View {
    @Binding var selectedDays: [Bool]
    
    var body: some View {
        HStack(spacing: WeekDayPicker.buttonSpacing) {
            ForEach(WeekDayPicker.days.indices, id: \.self) { dayIndex in
                DayPicker(dayOfWeekText: WeekDayPicker.days[dayIndex], selectionState: $selectedDays[dayIndex])
            }
        }
    }
    
    static let days: [String] = DateFormatter().veryShortWeekdaySymbols
    static let buttonSpacing: CGFloat = 4
}

struct DayPicker: View {
    var dayOfWeekText: String
    @Binding var selectionState: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(circleColor())
                .frame(width: DayPicker.circleDiameter)
                .opacity(DayPicker.circleOpacity)
            Text(dayOfWeekText)
                .fontWeight(fontWeight())
                .foregroundColor(fontColor())
        }
        .onTapGesture {
            withAnimation {
                selectionState.toggle()
            }
        }
    }
    
    private func circleColor() -> Color {
        selectionState ? .blue : .clear
    }
    
    private func fontColor() -> Color {
        selectionState ? .blue : .black
    }
    
    private func fontWeight() -> Font.Weight {
        selectionState ? .bold : .regular
    }
    
    private static let circleDiameter: CGFloat = 40
    private static let circleOpacity = 0.3
}

struct WeekDayPicker_Previews: PreviewProvider {
    static var previews: some View {
        WeekDayPicker(selectedDays: .constant([false, true, false, true, false, true, false]))
    }
}
