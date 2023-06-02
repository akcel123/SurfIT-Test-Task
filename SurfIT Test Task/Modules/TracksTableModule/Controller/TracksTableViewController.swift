//
//  TracksTableViewController.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import UIKit

final class TracksTableViewController: UIViewController {

    var tracks: [Track]!
    
    //MARK: - View elements properties
    private lazy var tracksTableView: UITableView = {
        let tableView = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame, style: .grouped)
        tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: TrackTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()

    //MARK: - initializers
    init(tracks: [Track]) {
        self.tracks = tracks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    


}

//MARK: - setupView
private extension TracksTableViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tracksTableView)
        
    }
}



//MARK: - UITableViewDelegate, UITableViewDataSource
extension TracksTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    //TODO: complete
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.reuseIdentifier) as! TrackTableViewCell
        
        cell.setupTrackName(tracks[indexPath.row].title + " - " + tracks[indexPath.row].artist)
        cell.setupTrackTime(tracks[indexPath.row].timeInSeconds.toTime())

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trackParameters = TrackParameters(name: tracks[indexPath.row].title, artistName: tracks[indexPath.row].artist, timeInSeconds: tracks[indexPath.row].timeInSeconds)
        
        let playingViewController = PlayingViewController(trackParameters: trackParameters)
        playingViewController.player.setNumberOfTrack(indexPath.row)
        present(playingViewController, animated: true)
    }
    
    
}

