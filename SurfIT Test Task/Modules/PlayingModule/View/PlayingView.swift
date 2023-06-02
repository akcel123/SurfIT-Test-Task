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
    
    private lazy var trackSlider: UISlider = {
        //FIXME: необходимо изменить слайдер, чтобы в нормальном состоянии было маленькое изображение, а в состоянии нажатия - большое
        // либо попробовать реализовать как на референсе, вообще без thumb
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)

        return slider
    }()
    
    private lazy var previousTrackButton = UIButton().createButtonForPlayingModule(systemImageName: "backward.end", target: self, action: #selector(previousButtonDidTapped))
    private lazy var playButton = UIButton().createButtonForPlayingModule(systemImageName: "play", target: self, action: #selector(playButtonDidTapped))
    private lazy var nextTrackButton = UIButton().createButtonForPlayingModule(systemImageName: "forward.end", target: self, action: #selector(nextButtonDidTapped))
    
    private lazy var closeButton = UIButton().createButtonForPlayingModule(systemImageName: "xmark", title: "Close", target: self, action: #selector(closeButtonDidTapped))
    
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

//MARK: - PlayingViewProtocol
extension PlayingView: PlayingViewProtocol {
    
    func setupTrackParameters(_ parameters: TrackParameters) {
        trackNameLabel.text = parameters.name
        artistNameLabel.text = parameters.artistName
        endTimeLabel.text = parameters.timeInSeconds.toTime()
        trackSlider.maximumValue = Float(parameters.timeInSeconds)
    }
    
    func setCurrentTime(_ timeInSeconds: Int) {
        currentTimeLabel.text = timeInSeconds.toTime()
        if trackSlider.isTouchInside {
            return
        }
        trackSlider.value = Float(timeInSeconds)
    }
    
    
    func pauseTrack() {
        let image = UIImage(systemName: "play")!
        playButton.setImage(image, for: .normal)
    }
    
    func playTrack() {
        let image = UIImage(systemName: "pause")!
        playButton.setImage(image, for: .normal)
    }
    
}




//MARK: - buttons and slider actions
extension PlayingView {
    @objc private func previousButtonDidTapped() {
        delegate?.previousButtonDidTapped()
    }
    
    @objc private func playButtonDidTapped() {
        delegate?.playButtonDidTapped()
    }
    
    @objc private func nextButtonDidTapped() {
        delegate?.nextButtonDidTapped()
    }
    
    @objc private func closeButtonDidTapped() {
        delegate?.closeButtonDidTapped()
    }
    
    @objc private func sliderTouchUpInside() {
        delegate?.sliderTouchUpInside(Int(trackSlider.value))
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

