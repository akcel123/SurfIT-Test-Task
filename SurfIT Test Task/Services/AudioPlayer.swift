//
//  AudioPlayer.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import Foundation
import MediaPlayer

class AudioPlayer {
    static let shared = AudioPlayer()

    
    let tracks = [
        Track(url: Bundle.main.url(forResource: "Track1", withExtension: "mp3")!),
        Track(url: Bundle.main.url(forResource: "Track2", withExtension: "mp3")!),
        Track(url: Bundle.main.url(forResource: "Track3", withExtension: "mp3")!),
        Track(url: Bundle.main.url(forResource: "Track4", withExtension: "mp3")!),
        Track(url: Bundle.main.url(forResource: "Track5", withExtension: "mp3")!),
    ]

    private init() {}

    lazy var player: AVPlayer = {
        let player = AVPlayer(url: AudioPlayer.shared.tracks[currentNumberOfTrack].url)
        player.currentItem?.allowedAudioSpatializationFormats = .multichannel
        return player
    }()
    
    private var currentNumberOfTrack = 0 {
        willSet {
            if newValue != currentNumberOfTrack {
                player.replaceCurrentItem(with: AVPlayerItem(url: AudioPlayer.shared.tracks[newValue].url))
                player.currentItem?.allowedAudioSpatializationFormats = .monoAndStereo
            }
            
        }
    }
    
    
    func nextTrack() {
        player.pause()
        if currentNumberOfTrack == tracks.count - 1 {
            currentNumberOfTrack = 0
        } else {
            currentNumberOfTrack += 1
        }
        player.play()
        
    }
    
    func previousTrack() {
        player.pause()
        if currentNumberOfTrack != 0 {
            currentNumberOfTrack -= 1
        } else {
            player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 1000))
        }
        player.play()
    }

    func getCurrentTrackParameters() -> TrackParameters {
        TrackParameters(name: tracks[currentNumberOfTrack].title, artistName: tracks[currentNumberOfTrack].artist, timeInSeconds: tracks[currentNumberOfTrack].timeInSeconds)
    }
    
    func setNumberOfTrack(_ num: Int) {
        currentNumberOfTrack = num
    }
    
    
}
