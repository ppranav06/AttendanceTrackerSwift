//
//  AddSubjectView.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 09/03/26.
//

import SwiftUI

struct AddSubjectView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var subject: Subject?
    
    @State private var name : String = ""
    @State private var selectedDays : [Weekday] = []
    @State private var showingDeleteButton : Bool = false
    
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
                    // shows only while editing subject, that's why let subject
                    Section("Delete") {
                        Button(role: .destructive) {
                            showingDeleteButton = true
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
                            let subject = Subject(context: viewContext)
                            subject.id = UUID()
                            subject.name = name
                            subject.days = selectedDays
                            do {
                                try viewContext.save()
                            } catch {
                                print("Failed to save subject: \(error.localizedDescription)")
                            }
                        }
                        dismiss()
                    }.disabled(!isSaveButtonValid)
                })
            }
            .confirmationDialog(String("This will permanently delete the subject \"\(subject?.name ?? "")\"."), isPresented: $showingDeleteButton, titleVisibility: .visible) {
                Button("Delete Subject", role: .destructive) {
                    // no point of return
                    if let subject {
                        viewContext.delete(subject)
                        do {
                            try viewContext.save()
                        } catch {
                            print("Failed to delete subject: \(error.localizedDescription)")
                        }
                        dismiss()
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
            
        }
        .onAppear {
            // When a subject is selected, preload values (Editing view)
            if let subject {
                name = subject.name ?? ""
                selectedDays = subject.days
            }
        }
    }
}

#Preview {
    let persistence = PersistenceController.shared
    AddSubjectView()
        .environment(
            \.managedObjectContext,
             persistence.container.viewContext
        )
}
