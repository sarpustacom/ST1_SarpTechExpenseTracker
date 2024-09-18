//
//  HomeView.swift
//  SarpTechExpenseTracker
//
//  Created by Sarp Ünsal on 16.09.2024.
//

import SwiftUI
import SwiftData
import Charts

struct HomeView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \PersonalTransaction.cost, order: .forward) var objects: [PersonalTransaction]
    
    @State private var current = 0
    @State private var payments = 0
    var body: some View {
        NavigationStack {
            Text("Your Balance")
                .font(.headline)
            Text("\(current)$")
                .font(.largeTitle)
                .bold()
                
            
            LabelView(systemName: "minus.circle.fill", title: "Total Payments: \(payments)$")
                .foregroundStyle(.red)
                .padding()
            
            LabelView(systemName: "plus.circle.fill",title:"Total Incoming: \(current + payments)$")
                .foregroundStyle(.green)
                .padding()
            
        }
        .navigationTitle("App")
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                NavigationLink(destination: {
                    AddExpenseView()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                })
            }
        })
        .onAppear(perform: {
            calculateCurrent()
            calculateAllPayments()
        })
        .onChange(of: objects) { oldValue, newValue in
            calculateCurrent()
            calculateAllPayments()
        }
    }
    
    func calculateCurrent(){
        current = 0
        objects.forEach { taa in
            current += taa.getMultipliedData()
        }
    }
        
    func calculateAllPayments(){
        payments = 0
        objects.forEach { pt in
            payments += pt.multiplier == -1 ? pt.cost : 0
        }
        
        
    }
}

#Preview {
    HomeView()
}

struct ExtractedView: View {
    var obj: PersonalTransaction
    var context: ModelContext
    var body: some View {
        HStack {
            Image(systemName: obj.multiplier == -1 ? "minus.circle.fill" : "plus.circle.fill")
                .foregroundStyle(obj.multiplier == -1 ? .red : .green)
            VStack(alignment: .leading) {
                Text(obj.name)
                if(obj.describe != "") {
                    Text(obj.describe)
                        .font(.caption)
                }
            }
            Spacer()
            Text("\(obj.getMultipliedData())$")
                .foregroundStyle(obj.multiplier == -1 ? .red : .green)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role:.destructive){
                context.delete(obj)
                do {
                    try context.save()
                } catch {
                    print("Error...")
                }
            } label: {
                Text("Remove")
            }
        }
    }
}
