//
//  MediBuddyApp.swift
//  MediBuddy
//
//  Created by Drew Litman on 5/17/23.
//

import SwiftUI

@main
struct MediBuddyApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
