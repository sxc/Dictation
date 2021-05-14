//
//  ContentView.swift
//  Shared
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        NavigationView {
            VStack {
                
                RecordingList(audioRecorder: audioRecorder)
                
                if audioRecorder.recording == false {
                    Button(action: { self.audioRecorder.startRecording()}) {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(audioRecorder: AudioRecorder())
    }
}
