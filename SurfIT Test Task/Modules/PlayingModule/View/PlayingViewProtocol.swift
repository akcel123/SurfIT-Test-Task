//
//  PlayingViewProtocol.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 02.06.2023.
//

import Foundation

protocol PlayingViewProtocol {
    func setupTrackParameters(_ parameters: TrackParameters)
    func setCurrentTime(_ timeInSeconds: Int)
    func pauseTrack()
    func playTrack()
    
    var delegate: PlayingViewControllerDelegate? { get set }
    
}
