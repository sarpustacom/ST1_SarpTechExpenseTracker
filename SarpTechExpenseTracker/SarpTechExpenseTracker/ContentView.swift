//
//  ContentView.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 16.09.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    LabelView(systemName: "house.circle.fill", title: "Home")
                }
            
            ExpensesView()
                .tabItem {
                    LabelView(systemName: "eurosign.circle.fill", title: "Expenses")
                }
            
            
            
            
        }
        
    }

   
}

#Preview {
    ContentView()
}

struct LabelView: View {
    var systemName: String
    var title: String
    var body: some View {
        HStack {
            Image(systemName: systemName)
            Text(title)
        }
    }
}
