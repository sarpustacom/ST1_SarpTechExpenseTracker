//
//  AddExpenseView.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 16.09.2024.
//

import SwiftUI

struct AddExpenseView: View {
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
                    guard let cost = cost else { return }
                    let model = PersonalTransaction(name: name, cost: cost, describe: description, date: date, isExpense: isExpense)
                    context.insert(model)
                    dismiss()
                }, label: {
                    Text("Add")
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
        
    }
}

#Preview {
    AddExpenseView()
}

