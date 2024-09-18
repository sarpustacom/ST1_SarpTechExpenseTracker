//
//  ExpensesView.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 16.09.2024.
//

import SwiftUI
import SwiftData
struct ExpensesView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \PersonalTransaction.cost, order: .forward) var objects: [PersonalTransaction]
    var body: some View {
        List(objects, id:\.name.hashValue) { obj in
            NavigationLink {
                EditExpenseView(transaction: obj)
            } label: {
                ExtractedView(obj: obj, context: context)
            }
        }
        
    }
}

#Preview {
    ExpensesView()
}
