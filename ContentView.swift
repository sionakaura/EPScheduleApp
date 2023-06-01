//
//  ContentView.swift
//  EPHSScheduleApp
//
//  Created by 64001567 on 5/31/23.
//

import SwiftUI
//reqs 2+3: homepage w schedule AND ability to edit
struct ContentView: View {
    @State private var showIntroduction = true

    var body: some View {
        TabView {
            if showIntroduction {
                IntroductionView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
            }

            ContentViewSchedule()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Regular")
                }
            
            FlexViewSchedule()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2.fill")
                    Text("Flex")
                }
            
            HelpfulLinksView()
                .tabItem {
                    Image(systemName: "link")
                    Text("Links")
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showIntroduction = false
            }
        }
    }
}
    
    struct HourInfo {
        var classInfo: String = ""
        var teacherInfo: String = ""
        var locationInfo: String = ""
        var notesInfo: String = ""
    }
    
    struct ContentViewSchedule: View {
        let scheduleTimes = [
            ("8:35 AM", "10:03 AM"),
            ("10:10 AM", "11:38 AM"),
            ("11:45 AM", "1:45 PM"),
            ("1:52 PM", "3:20 PM")
        ]
        
        @State private var classInfo = [String](repeating: "", count: 4)
        @State private var teacherInfo = [String](repeating: "", count: 4)
        @State private var locationInfo = [String](repeating: "", count: 4)
        @State private var notesInfo = [String](repeating: "", count: 4)
        @State private var showPopup = false
        @State private var popupIndex = 0
        @State private var popupClass = ""
        @State private var popupTeacher = ""
        @State private var popupLocation = ""
        @State private var popupNotes = ""
        
        var body: some View {
            ZStack {
                Color.red.edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Regular Schedule")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 75)
                        
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
                                    Text("Location: \(locationInfo[index])")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                    Text("Additional Notes: \(notesInfo[index])")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)
                                    
                                    Button(action: {
                              
                                        print("Update button tapped for hour \(index + 1)")
                                        showPopup = true
                                        popupIndex = index
                                    }) {
                                        Text("Update Info")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 8)
                                            .background(Color.blue)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                            
                            Spacer() 
                                .frame(height: 200) // Adjust the height as needed
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showPopup) {
                VStack(alignment: .leading, spacing: 8) {
                    TextField("Class", text: $popupClass)
                    TextField("Teacher", text: $popupTeacher)
                    TextField("Location", text: $popupLocation)
                    TextField("Additional Notes", text: $popupNotes)
                    
                    Button(action: {
                        //  save button is tapped
                        classInfo[popupIndex] = popupClass
                        teacherInfo[popupIndex] = popupTeacher
                        locationInfo[popupIndex] = popupLocation
                        notesInfo[popupIndex] = popupNotes
                        showPopup = false
                    }) {
                        Text("Save")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }

//req 4: flex view    
    struct FlexViewSchedule: View {
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
        @State private var locationInfo = [String](repeating: "", count: 6)
        @State private var notesInfo = [String](repeating: "", count: 6)
        @State private var showPopup = false
        @State private var popupIndex = 0
        @State private var popupClass = ""
        @State private var popupTeacher = ""
        @State private var popupLocation = ""
        @State private var popupNotes = ""

        var body: some View {
            ZStack {
                Color.red.edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Flex Schedule")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 75)

                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(0..<scheduleTimes.count) { index in
                                let startTime = scheduleTimes[index].0
                                let endTime = scheduleTimes[index].1

                                VStack(alignment: .leading, spacing: 5) {
                                    if index == 1 {
                                        Text("Connections: 9:45 AM - 10:05 AM")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    } else if index == 5 {
                                        Text("FLEX: 2:40 PM - 3:20 PM")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    } else {
                                        let hourIndex = index < 2 ? index + 1 : index
                                        Text("Hour \(hourIndex): \(startTime) - \(endTime)")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    if index != 5 {
                                        Text("Class: \(classInfo[index])")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                        Text("Teacher: \(teacherInfo[index])")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                        Text("Location: \(locationInfo[index])")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                    }
                                    Text("Additional Notes: \(notesInfo[index])")
                                        .font(.system(size: 18))
                                        .foregroundColor(.white)

                                    Button(action: {
                                       // button is tapped
                                        print("Update button tapped for hour \(index + 1)")
                                        showPopup = true
                                        popupIndex = index
                                    }) {
                                        Text("Update Info")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 8)
                                            .background(Color.blue)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                        }
                        .padding(.horizontal)
                        Spacer(minLength: 200) 
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showPopup) {
                VStack(alignment: .leading, spacing: 8) {
                    if popupIndex != 5 {
                        TextField("Class", text: $popupClass)
                        TextField("Teacher", text: $popupTeacher)
                        TextField("Location", text: $popupLocation)
                    }
                    TextField("Additional Notes", text: $popupNotes)

                    Button(action: {
                        //  save button is tapped
                        classInfo[popupIndex] = popupClass
                        teacherInfo[popupIndex] = popupTeacher
                        locationInfo[popupIndex] = popupLocation
                        notesInfo[popupIndex] = popupNotes
                        showPopup = false
                    }) {
                        Text("Save")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }

//strectchreq: link page
    struct HelpfulLinksView: View {
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Helpful Links")
                        .font(.system(size: 36, weight: .bold))
                        .padding(.top, 75)
                    
                    LinkButton(title: "EPHS Lunch Schedule", url: "https://www.edenpr.org/eden-prairie-high-school/student-life/news-information/school-schedule")
                    LinkButton(title: "EPHS Student Life Calendar", url: "https://www.edenpr.org/eden-prairie-high-school/student-life/calendar")
                    LinkButton(title: "EPHS Career and Counseling Center", url: "https://www.edenpr.org/eden-prairie-high-school/student-life/career-counseling")
                    LinkButton(title: "EPHS News and Information", url: "https://www.edenpr.org/eden-prairie-high-school/student-life/news-information")
                
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(Color.red) // red background color to ScrollView
        }
    }

    struct LinkButton: View {
        var title: String
        var url: String
        
        var body: some View {
            Button(action: {
                if let linkURL = URL(string: url) {
                    UIApplication.shared.open(linkURL)
                }
            }) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.bottom, 10)
            }
        }
    }

//req 1: intro screen
struct IntroductionView: View {
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("EPHS Schedule App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //contentview displays after 3 secs
            }
        }
    }
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

