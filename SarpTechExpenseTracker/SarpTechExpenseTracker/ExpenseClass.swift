//
//  ExpenseClass.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 16.09.2024.
//

import Foundation
import SwiftData

@Model
class PersonalTransaction {
    var name: String
    var cost: Int
    var describe : String
    var date: Date
    var multiplier: Int
    init(name: String, cost: Int,describe: String = "", date: Date = Date.now, isExpense: Bool = true) {
        self.name = name
        self.cost = cost
        self.multiplier = isExpense ? -1 : +1
        self.describe = describe
        self.date = date
    }
    func getMultipliedData() -> Int {
        return multiplier*cost
    }
    
    func isExpense() -> Bool {
        return multiplier == -1
    }
}

