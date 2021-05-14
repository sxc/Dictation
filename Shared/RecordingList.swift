//
//  RecordingList.swift
//  Dictation
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import SwiftUI

struct RecordingList: View {
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            Text("Empty list")
        }
    }
}

struct RecordingList_Previews: PreviewProvider {
    static var previews: some View {
        RecordingList(audioRecorder: AudioRecorder())
    }
}
