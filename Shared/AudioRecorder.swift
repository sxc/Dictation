//
//  AudioRecorder.swift
//  Dictation
//
//  Created by Xiaochun Shen on 2021/5/14.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecoder: AVAudioRecorder!
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
}
