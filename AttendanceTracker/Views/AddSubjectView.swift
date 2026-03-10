//
//  AddSubjectView.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 09/03/26.
//

import SwiftUI

struct AddSubjectView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name : String = ""
    @State private var selectedDays : [Weekday] = []
    
    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !selectedDays.isEmpty
    }
    
    private func dayBinding(for day: Weekday) -> Binding<Bool> {
        Binding(
            get: {
                selectedDays.contains(day)
            },
            set: { isOn in
                if isOn {
                    selectedDays.append(day)
                } else {
                    selectedDays.removeAll { $0 == day }
                }
            }
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Subject") {
                    TextField("Subject Name", text: $name)
                }
                
                Section("Days") {
                    ForEach(Weekday.allCases, id: \.self) { day in
                        Toggle(
                            day.rawValue.capitalized,
                            isOn: dayBinding(for: day)
                        )
                    }
                }
            }
            .navigationTitle("Add Subject")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction, content: {
                    Button("Save") {
                        let subject = Subject(name: name, days: selectedDays)
                        context.insert(subject)
                        dismiss()
                    }.disabled(!isValid)
                })
            }
        }
//        .onAppear {
//            if let subject {
//                name = subject.name
//                selectedDays = subject.days
//            }
//        }
    }
}

#Preview {
    AddSubjectView()
        .modelContainer(for: Subject.self, inMemory:true)
}
