//
//  FlexView.swift
//  EPHSScheduleApp
//
//  Created by 64001567 on 5/31/23.
//

import SwiftUI

struct FlexView: View {
    let scheduleTimes = [
        ("8:35 AM", "9:38 AM"),
        ("9:45 AM", "10:05 AM"),
        ("10:12 AM", "11:15 AM"),
        ("11:22 AM", "1:22 PM"),
        ("1:29 PM", "2:33 PM"),
        ("2:40 PM", "3:20 PM")
    ]

    @State private var classInfo = [String](repeating: "", count: 6)
    @State private var teacherInfo = [String](repeating: "", count: 6)
    @State private var notesInfo = [String](repeating: "", count: 6)
    @State private var showPopup = false
    @State private var popupIndex = 0
    @State private var popupClass = ""
    @State private var popupTeacher = ""
    @State private var popupNotes = ""

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 10) {
                Text("Flex Schedule")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 40)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(0..<scheduleTimes.count) { index in
                        let startTime = scheduleTimes[index].0
                        let endTime = scheduleTimes[index].1

                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hour \(index + 1): \(startTime) - \(endTime)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            Text("Class: \(classInfo[index])")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            Text("Teacher: \(teacherInfo[index])")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            Text("Additional Notes: \(notesInfo[index])")
                                .font(.system(size: 18))
                                .foregroundColor(.white)

                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Update button tapped for hour \(index + 1)")
                                showPopup = true
                                popupIndex = index
                            }) {
                                Text("Update Info")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                                    .background(Color.orange)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showPopup) {
            VStack(alignment: .leading, spacing: 8) {
                TextField("Class", text: $popupClass)
                TextField("Teacher", text: $popupTeacher)
                TextField("Additional Notes", text: $popupNotes)

                Button(action: {
                    // Action to perform when the save button is tapped
                    classInfo[popupIndex] = popupClass
                    teacherInfo[popupIndex] = popupTeacher
                    notesInfo[popupIndex] = popupNotes
                    showPopup = false
                }) {
                    Text("Save")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}


struct FlexView_Previews: PreviewProvider {
    static var previews: some View {
        FlexView()
    }
}
