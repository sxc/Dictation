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
    var body: some View {
        VStack(spacing: 20) {
            Text(title).font(.largeTitle)
            Text(subtitle).font(.title).foregroundColor(.gray)
//            Text("By change the State variable, you can trigger the Sheet to show")
            
            Spacer()
            
            Text("0:33:25").font(.largeTitle)
            
            Spacer()
            Image(systemName: "stop.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .foregroundColor(.red)
                .padding(.bottom, 40)
            
            
            Spacer()
            Button("Dismiss") {
                self.presentation.wrappedValue.dismiss()
            }
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
