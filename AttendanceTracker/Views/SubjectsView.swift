//
//  SubjectsView.swift
//  AttendanceTracker
//
//  Created by Pranav Krishna P on 09/03/26.
//

import SwiftUI
import SwiftData

struct SubjectsView: View {
    @Environment(\.modelContext) private var context
    @Query private var subjects: [Subject]
    
    @State private var showingAddSubject = false
    @State private var showingIndividualSubject = false
    
    @State var selectedSubject: Subject?

    var body: some View {
        NavigationStack {
            Text("Count: \(subjects.count)")
            List {
                ForEach(subjects) { subject in
                    Button{
                        selectedSubject = subject
                        showingAddSubject = true
                    } label: {
                        Text(subject.name)
                    }
                }
            }

            .navigationTitle("Subjects")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        selectedSubject = nil // for adding a new subject
                        showingAddSubject = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSubject){
                AddSubjectView(subject: selectedSubject)
            }
        }
    }
}

#Preview {
    SubjectsView()
        .modelContainer(for: Subject.self, inMemory: false)
}
