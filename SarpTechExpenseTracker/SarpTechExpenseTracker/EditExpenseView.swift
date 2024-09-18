//
//  EditExpenseView.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 18.09.2024.
//

import SwiftUI

struct EditExpenseView: View {
    var transaction: PersonalTransaction
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var cost: Int?
    @State private var isExpense = true
    @State private var description = ""
    @State private var date = Date()
    private var formValidation : Bool {
        cost != nil && !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    var body: some View {
        VStack {
            Form {
                TextField("Expense Name", text: $name)
                TextField("Cost ($)",value: $cost,format: .number)
                TextField("Description", text: $description)
                DatePicker(selection: $date, displayedComponents: DatePickerComponents(arrayLiteral: [.date, .hourAndMinute])) {
                    Text("Date")
                }
                Toggle(isOn: $isExpense, label: {
                    Text("\(isExpense ? "Expense" : "Income")")
                })
            }
        }.toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    
                    
                    transaction.name = name
                    transaction.cost = cost ?? 0
                    transaction.describe = description
                    transaction.multiplier = isExpense ? -1 : 1
                    transaction.date = date
                    
                    do {
                        try context.save()
                    } catch let error {
                        print("Error : \(error.localizedDescription)")
                    }
                    
                    dismiss()
                }, label: {
                    Text("Update")
                }).disabled(!formValidation)
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Dismiss")
                }).disabled(!formValidation)
            }
        })
        .onAppear {
            name = transaction.name
            date = transaction.date
            isExpense = transaction.isExpense()
            description = transaction.describe
            cost = transaction.cost
            
            
        }
    }
}

#Preview {
    EditExpenseView(transaction: .init(name: "Rent", cost: 300, date: Date.now ,isExpense: true))
}
