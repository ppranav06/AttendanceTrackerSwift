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
    
    var subject: Subject?
    
    @State private var name : String = ""
    @State private var selectedDays : [Weekday] = []
    
    private var title: String {
        if subject != nil{
            "Edit Subject"
        } else {
            "Add Subject"
        }
    }
    
    private var isSaveButtonValid: Bool {
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
                
                if let subject {
                    Section {
                        Button(role: .destructive) {
                            // shows in destructive style when subject is not nil
                            context.delete(subject)
                            dismiss()
                        } label: {
                            Text("Delete Subject")
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction, content: {
                    Button("Save") {
                        if let subject {
                            subject.name = name
                            subject.days = selectedDays
                        } else {
                            let subject = Subject(name: name, days: selectedDays)
                            context.insert(subject)
                        }
                        dismiss()
                    }.disabled(!isSaveButtonValid)
                })
            }
        }
        .onAppear {
            // When a subject is selected, preload values (Editing view)
            if let subject {
                name = subject.name
                selectedDays = subject.days
            }
        }
    }
}

#Preview {
    AddSubjectView()
        .modelContainer(for: Subject.self, inMemory:true)
}
