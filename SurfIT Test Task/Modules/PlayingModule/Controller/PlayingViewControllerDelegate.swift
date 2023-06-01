//
//  PlayingViewControllerDelegate.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import Foundation

protocol PlayingViewControllerDelegate: AnyObject {
    func previousButtonDidTapped()
    func playButtonDidTapped()
    func nextButtonDidTapped()
    func closeButtonDidTapped()
}
