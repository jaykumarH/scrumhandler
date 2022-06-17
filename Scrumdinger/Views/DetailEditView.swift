//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Jaykumar on 2022-06-15.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting info"), content: {
                TextField("Meeting Title...", text: $data.title)
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $data.theme)
            })
            
            Section(header: Text("Attendees"), content: {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete(perform: { indices in
                    data.attendees.remove(atOffsets: indices)
                })
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(
                        action: {
                            withAnimation{
                                let newAttendee = DailyScrum.Attendee(name: newAttendeeName)
                                data.attendees.append(newAttendee)
                                newAttendeeName = ""
                            }
                        },
                        label: {
                            Image(systemName: "plus.circle.fill")
                                .accessibilityLabel("Add attendee")
                        }
                    )
                    .disabled(newAttendeeName.isEmpty)
                }
            })
            
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}