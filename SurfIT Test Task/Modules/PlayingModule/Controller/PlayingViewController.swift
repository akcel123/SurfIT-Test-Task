//
//  PlayingViewController.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import UIKit
import AVFAudio

final class PlayingViewController: UIViewController {
    var player: AVAudioPlayer!
    var trackParameters: TrackParameters
    
    private var playingView: PlayingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        playingView = PlayingView(frame: view.frame, parameters: trackParameters)
        view.addSubview(playingView)
        playingView.setCurrentTime("00:00")
        playingView.delegate = self
        
    }
    
    init(trackParameters: TrackParameters) {
        self.trackParameters = trackParameters
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}

extension PlayingViewController: PlayingViewControllerDelegate {
    func previousButtonDidTapped() {
        
    }
    
    func playButtonDidTapped() {
        
    }
    
    func nextButtonDidTapped() {
        
    }
    
    func closeButtonDidTapped() {
        dismiss(animated: true)
    }
    
    
}
