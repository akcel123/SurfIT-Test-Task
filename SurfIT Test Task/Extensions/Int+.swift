//
//  Int+.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import Foundation

extension Int {
    func toTime() -> String {
        return String(format: "%02i:%02i", (self / 60) % 60, self % 60)
    }
}
