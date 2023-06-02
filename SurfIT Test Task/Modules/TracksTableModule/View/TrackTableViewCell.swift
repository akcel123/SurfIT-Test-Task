//
//  TrackTableViewCell.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import UIKit

final class TrackTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TrackTableViewCell"
    
    //MARK: - View elements properties
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(trackNameLabel)
        addSubview(timeLabel)
        self.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    //MARK: - public funcs
    public func setupTrackName(_ name: String) {
        trackNameLabel.text = name
    }
    
    public func setupTrackTime(_ time: String) {
        timeLabel.text = time
    }

}

//MARK: - Constraints
private extension TrackTableViewCell {
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            trackNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            trackNameLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -12),
            trackNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            timeLabel.centerYAnchor.constraint(equalTo: trackNameLabel.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
        
    }
}
