//
//  ContentView.swift
//  Shared
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    @State var searchText = ""
    
    @State private var presentingSheet = false
    
    var body: some View {
        NavigationView {
//            VStack(alignment: .leading)  {
            VStack {
                SearchBar(searchText: $searchText)
                
                RecordingList(audioRecorder: audioRecorder)
                
                if audioRecorder.recording == false {
                    Button(action: {
                            self.audioRecorder.startRecording()
                        
                            self.presentingSheet = true
                        

                        
                    }

                    
                    ) {
                        

                        
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: { self.audioRecorder.stopRecording()}) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
                
            
                
            }
            .navigationTitle("Voice recorder")
            .navigationBarItems(trailing: EditButton())
        }
        
        .sheet(isPresented: $presentingSheet) {
            ModalView(title: "Recording",
                      subtitle: "Presenting with Bool")
        }
    }
}

struct Sheet_PresentingWithBool: View {
    @State private var presentingSheet = false
    var body: some View {
        Button("show modal") {
            self.presentingSheet = true
        }
        .sheet(isPresented: $presentingSheet) {
            ModalView(title: "Sheet",
                      subtitle: "Presenting with Bool")
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentation
    let title: String
    let subtitle: String
    @State private var phase = 0.0
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title).font(.largeTitle)
//            Text(subtitle).font(.title).foregroundColor(.gray)
//            Text("By change the State variable, you can trigger the Sheet to show")
            
            Spacer()
            
            Text("0:33:25").font(.largeTitle)
            
            ZStack {
                        ForEach(0..<2) { i in
                            Wave(strength: 50, frequency: 10, phase: self.phase)
            
                                .stroke(Color.blue, lineWidth: 3)
                        }
                    }
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                            self.phase = .pi * 2
                        }
                    }
            
            Spacer()
            Button(action:
                    {
                
                        self.presentation.wrappedValue.dismiss()
                        
                        
                    }) {
                Image(systemName: "stop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .foregroundColor(.red)
                    .padding(.bottom, 40)
            }
                
            
            
            
            Spacer()
            
        }
    }
}



struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color("LightGray"))
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText)
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}


struct Wave: Shape {
    // allow SwiftUI to animate the wave phase
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue }
    }

    // how high our waves should be
    var strength: Double

    // how frequent our waves should be
    var frequency: Double

    // how much to offset our waves horizontally
    var phase: Double

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        // calculate some important values up front
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height / 2
        let oneOverMidWidth = 1 / midWidth

        // split our total width up based on the frequency
        let wavelength = width / frequency

        // start at the left center
        path.move(to: CGPoint(x: 0, y: midHeight))

        // now count across individual horizontal points one by one
        for x in stride(from: 0, through: width, by: 1) {
            // find our current position relative to the wavelength
            let relativeX = x / wavelength

            // find how far we are from the horizontal center
            let distanceFromMidWidth = x - midWidth

            // bring that into the range of -1 to 1
            let normalDistance = oneOverMidWidth * distanceFromMidWidth

            let parabola = -(normalDistance * normalDistance) + 1

            // calculate the sine of that position, adding our phase offset
            let sine = sin(relativeX + phase)

            // multiply that sine by our strength to determine final offset, then move it down to the middle of our view
            let y = parabola * strength * sine + midHeight

            // add a line to here
            path.addLine(to: CGPoint(x: x, y: y))
        }

        return Path(path.cgPath)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
