//
//  CalendarView.swift
//  ShareMyCariOS
//
//  Created by Bas Buijsen on 31/01/2022.
//

import SwiftUI
import KVKCalendar
import EventKit

struct CalendarDisplayView: UIViewRepresentable {
    @Binding var events: [Event]
    @Binding var showDetailPage: Bool
    @Binding var lastRide : Ride

    private var calendar: CalendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 300))
        
    func makeUIView(context: UIViewRepresentableContext<CalendarDisplayView>) -> CalendarView {
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        calendar.reloadData()
        
        return calendar
    }
    
    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<CalendarDisplayView>) {
        context.coordinator.events = events
    }
    
    func makeCoordinator() -> CalendarDisplayView.Coordinator {
        Coordinator(self, showDetail: $showDetailPage, ride: $lastRide)
    }
    
    public init(events: Binding<[Event]>, size : CGRect, showDetail: Binding<Bool>, ride : Binding<Ride>) {
        self._events = events
        var style : Style = Style()
        style.followInSystemTheme = true
        calendar = CalendarView(frame: size, style: style)
        _showDetailPage = showDetail
        _lastRide = ride
    }
    
    // MARK: Calendar DataSource and Delegate
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {
        private let view: CalendarDisplayView
        @Binding var showDetail : Bool
        @Binding var lastRide : Ride
        
        var events: [Event] = [] {
            didSet {
                view.calendar.reloadData()
            }
        }
        
        init(_ view: CalendarDisplayView, showDetail : Binding<Bool>, ride : Binding<Ride>) {
            self.view = view
            _showDetail = showDetail
            _lastRide = ride
            super.init()
        }
        
        func eventsForCalendar(systemEvents: [EKEvent]) -> [Event] {
            return events
        }
        
        func didSelectEvent(_ event: Event, type: CalendarType, frame: CGRect?) {
            print(event)
            if let data = event.data as? Ride {
                lastRide = data
                showDetail = true
            }
        }
    }
    
}


