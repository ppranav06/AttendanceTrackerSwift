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
    
    var selectedSubject: Subject?

    var body: some View {
        NavigationStack {
            Text("Count: \(subjects.count)")
            List(subjects) { subject in
                    Text(subject.name)
            }

            .navigationTitle("Subjects")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddSubject = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSubject){
                AddSubjectView()
            }
        }
    }
}

#Preview {
    SubjectsView()
        .modelContainer(for: Subject.self, inMemory: false)
}
