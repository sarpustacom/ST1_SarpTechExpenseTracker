//
//  SarpTechExpenseTrackerApp.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 16.09.2024.
//

import SwiftUI
import SwiftData

@main
struct SarpTechExpenseTrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    
            }
            
        }.modelContainer(for: PersonalTransaction.self)
        
    }
}
