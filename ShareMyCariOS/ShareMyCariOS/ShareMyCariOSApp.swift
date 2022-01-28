//
//  ShareMyCariOSApp.swift
//  ShareMyCariOS
//
//  Created by Bas Buijsen on 27/01/2022.
//

import SwiftUI

@main
struct ShareMyCariOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var menu : MenuItem = .login
    
    var body: some Scene {
        WindowGroup {
            ContentView(menu: $menu)
        }
    }
}
