//
//  DictationApp.swift
//  Shared
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import SwiftUI

@main
struct DictationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(audioRecorder: AudioRecorder())
        }
    }
}
