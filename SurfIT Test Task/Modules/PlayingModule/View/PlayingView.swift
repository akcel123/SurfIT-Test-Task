//
//  PlayingView.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import UIKit


final class PlayingView: UIView {

    weak var delegate: PlayingViewControllerDelegate?
    
    //MARK: - View elements properties
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let trackSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = .clear
        
        return slider
    }()
    
    private lazy var previousTrackButton = UIButton().createButtonForPlayingModule(systemImageName: "backward.end", target: self, action: #selector(previousButtonDidTapped))
    private lazy var playButton = UIButton().createButtonForPlayingModule(systemImageName: "play", target: self, action: #selector(playButtonDidTapped))
    private lazy var nextTrackButton = UIButton().createButtonForPlayingModule(systemImageName: "forward.end", target: self, action: #selector(nextButtonDidTapped))
    
    private lazy var closeButton = UIButton().createButtonForPlayingModule(systemImageName: "cross", title: "Close", target: self, action: #selector(closeButtonDidTapped))
    
    //MARK: - Initializer
    
    init(frame: CGRect, parameters: TrackParameters) {
        super.init(frame: frame)
        setupTrackParameters(parameters)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}

//MARK: - buttons actions
extension PlayingView {
    @objc func previousButtonDidTapped() {
        delegate?.previousButtonDidTapped()
    }
    
    @objc func playButtonDidTapped() {
        delegate?.playButtonDidTapped()
    }
    
    @objc func nextButtonDidTapped() {
        delegate?.nextButtonDidTapped()
    }
    
    @objc func closeButtonDidTapped() {
        delegate?.closeButtonDidTapped()
    }
}

//MARK: - setup Views
private extension PlayingView {
    func setupView() {
        addSubviews([trackNameLabel, artistNameLabel])
        addSubviews([currentTimeLabel, endTimeLabel, trackSlider])
        addSubviews([previousTrackButton, playButton, nextTrackButton])
        addSubview(closeButton)
        setupConstraints()
    }
}

//MARK: - Constraints
private extension PlayingView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            trackNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            trackNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 256),
            
            artistNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 12),
            
            currentTimeLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 24),
            currentTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            
            endTimeLabel.topAnchor.constraint(equalTo: currentTimeLabel.topAnchor),
            endTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            
            trackSlider.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 16),
            trackSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.leadingAnchor),
            trackSlider.trailingAnchor.constraint(equalTo: endTimeLabel.trailingAnchor),
            
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: trackSlider.bottomAnchor, constant: 24),
            
            previousTrackButton.topAnchor.constraint(equalTo: playButton.topAnchor),
            previousTrackButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -32),
            
            nextTrackButton.topAnchor.constraint(equalTo: playButton.topAnchor),
            nextTrackButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 32),
        
        ])
    }
}

//MARK: - Change View Properties
extension PlayingView {
    private func setupTrackParameters(_ parameters: TrackParameters) {
        trackNameLabel.text = parameters.name
        artistNameLabel.text = parameters.artistName
        endTimeLabel.text = parameters.time
    }
    
    public func setCurrentTime(_ time: String) {
        currentTimeLabel.text = time
    }
}
