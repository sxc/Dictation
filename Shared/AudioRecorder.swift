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

class AudioRecorder: NSObject, ObservableObject {
    
    override init() {
        super.init()
        fetchRecordings()
    }
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    
    var audioRecoder: AVAudioRecorder!
    var recordings = [Recording]()
    
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
//        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "YY-MM-dd HH:mm:ss"))")
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "HH-mm-ss"))")
        
        do {
            audioRecoder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecoder.record()
            
            recording = true
        } catch {
            print("Could not start recording")
        }

    }
    
    func stopRecording() {
        audioRecoder.stop()
        recording = false
        
        fetchRecordings()
    }
    
    func fetchRecordings() {
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDicrctory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDicrctory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
        objectWillChange.send(self)
        
    }
    
    func deleteRecording(urlsToDelete: [URL]) {
        for url in urlsToDelete {
            print(url)
            do {
                try FileManager.default.removeItem(at: url)
                
            } catch {
                print("File could not be deleted!")
            }
        }
        fetchRecordings()
    }
    
}
