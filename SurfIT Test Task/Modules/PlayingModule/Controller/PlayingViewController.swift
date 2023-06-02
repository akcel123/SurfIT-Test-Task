//
//  PlayingViewController.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import UIKit
import MediaPlayer

final class PlayingViewController: UIViewController {
    
    private var trackParameters: TrackParameters
    let player = AudioPlayer.shared
    private var playingView: PlayingViewProtocol!
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupPlayer()
    }
    

    
    //MARK: - initializers
    
    init(trackParameters: TrackParameters) {
        self.trackParameters = trackParameters
        super.init(nibName: nil, bundle: nil)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

//MARK: - setup view and player
private extension PlayingViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        playingView = PlayingView(frame: view.frame, parameters: trackParameters)
        view.addSubview(playingView as! UIView)
        playingView.delegate = self
        playingView.setCurrentTime(Int(player.player.currentTime().seconds))
        if player.player.timeControlStatus != .playing {
            playingView.pauseTrack()
        } else {
            playingView.playTrack()
            
        }

    }
    
    func setupPlayer() {
        player.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: .main) { [weak self] time in
            self?.playingView.setCurrentTime(Int(time.seconds))
            if time.seconds > 1.0 {
                if Int(time.seconds) == Int(self?.player.player.currentItem?.duration.seconds ?? 0)  {
                    self?.nextButtonDidTapped()
                }
                
            }
        }
    }
    
}

//MARK: - PlayingViewControllerDelegate
extension PlayingViewController: PlayingViewControllerDelegate {

    func previousButtonDidTapped() {
        player.previousTrack()
        self.playingView.setupTrackParameters(player.getCurrentTrackParameters())
        self.playingView.setCurrentTime(0)
    }
    
    func playButtonDidTapped() {
        if player.player.timeControlStatus == .playing {
            player.player.pause()
            playingView.pauseTrack()
        } else {
            player.player.play()
            playingView.playTrack()
            
        }
        
    }
    
    func nextButtonDidTapped() {
        player.nextTrack()
        self.playingView.setupTrackParameters(player.getCurrentTrackParameters())
        self.playingView.setCurrentTime(0)

    }
    
    func closeButtonDidTapped() {
        dismiss(animated: true)
    }
    
    func sliderValueChanged(_ newValue: Int) {
        player.player.seek(to: CMTime(seconds: Double(newValue), preferredTimescale: 1000))
        playingView.setCurrentTime(newValue)
    }
    
}
