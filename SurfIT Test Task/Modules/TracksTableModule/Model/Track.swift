//
//  Track.swift
//  SurfIT Test Task
//
//  Created by Денис Павлов on 01.06.2023.
//

import Foundation
import AVFoundation



class Track {
    let url: URL
    private var (titleString, artistString) : (String?, String?)
    private var trackTime: Int!
    
    var title: String {
        titleString ?? url.lastPathComponent.components(separatedBy: ".")[0]
    }
    
    var artist: String {
        artistString ?? "Неизвестный исполнитель"
    }
    
    var timeInSeconds: Int {
        trackTime
    }

    init(url: URL) {
        self.url = url
        let metadata = getMetadataFromMP3(fileURL: url)
        (titleString, artistString, trackTime) = metadata
        //FIXME: не могу адаптировать считывание метаданных под новое API, на данный момент идей нет
//        Task {
//            do {
//                let metadata = try await self.getMetadata()
//                (titleString, artistString, trackTime) = metadata
//            } catch {
//                print("No metadata in file, use correct file")
//            }
//        }
        
    }
    
    // FIXME: необходимо реализовать работу с асинхронной функцией. Сейчас используется старый API
    func getMetadata() async throws -> (title: String?, artist: String?, time: Int) {
        var title: String?
        var artist: String?
    
        
        let asset = AVAsset(url: url)
        let commonMetadata = try await asset.load(.commonMetadata)
        let duration = try await asset.load(.duration)
        

        for metadataItem in commonMetadata {
            guard let key = metadataItem.commonKey?.rawValue, let value = try await metadataItem.load(.value) else {
                continue
            }

            switch key {
            case "title":
                title = value as? String
            case "artist":
                artist = value as? String
            default:
                break
            }
        }
        
        return (title, artist, Int(duration.seconds))

    }
    
    func getMetadataFromMP3(fileURL: URL) -> (title: String?, artist: String?, time: Int) {
        var title: String?
        var artist: String?
        
        let asset = AVAsset(url: fileURL)
        let commonMetadata = asset.commonMetadata
        let duration = asset.duration
        for metadataItem in commonMetadata {
            guard let key = metadataItem.commonKey?.rawValue, let value = metadataItem.value else {
                continue
            }
            
            switch key {
            case "title":
                title = value as? String
            case "artist":
                artist = value as? String
            default:
                break
            }
        }
        
        return (title, artist, Int(duration.seconds))
    }

}
