//
//  main.swift
//  MusicPlaylist
//
//  Created by Валерия Пономарева on 07.11.2025.
//

import Foundation

print("Task: 'Music Playlist'.")

enum MusicGenre: String, CaseIterable {
    case pop = "Pop"
    case rock = "Rock"
    case jazz = "Jazz"
    
    // Можно добавлять методы!
    var emoji: String {
        switch self {
        case .pop: return "🎵"
        case .rock: return "🎸"
        case .jazz: return "🎷"
        }
    }
}

struct Song: Equatable {
    var title: String
    let artist: String
    var duration: Double // продолжительность in seconds
    let genre: MusicGenre
    var isPlaying: Bool
}

class Playlist {
    private var songs: [Song] = []
    
    init(songs: [Song]) {
        self.songs = songs
    }
    init() { } // для создания ПУСТОГО плейлиста
    
    func addSong(_ song: Song) {
        songs.append(song)
    }
    
    func removeSong(title: String) {
        if let index = songs.firstIndex(where: { $0.title == title }) {
            songs.remove(at: index)
        }
    }
    
    func playSong(title: String) -> Bool {
        // Просто находим и включаем, не заботясь об остальных
        if let index = songs.firstIndex(where: { $0.title == title }) {
            songs[index].isPlaying = true
            return true
        }
        return false
    }
    
    func stopSong(title: String) { // остановить песню, которая УЖЕ играет
        if let index = songs.firstIndex(where: {$0.title == title }) {
            songs[index].isPlaying = false // меняем статус на false - остановка!
        } else {
        }
    }
    
    func getTotalDuration() -> Double {
        return songs.reduce(0) { $0 + $1.duration }
    }
    
    func findSongs(by artist: String) -> [Song] { // найди песню по исполнителю
        return songs.filter {$0.artist == artist }
    }
    
    func getNowPlaying() -> Song? { // исполняется сейчас?
        return songs.first(where: { $0.isPlaying })
    }
}

print("-- Тесты плейлиста --")

// Создаем песни
let song1 = Song(title: "Bohemian Rhapsody", artist: "Queen", duration: 354, genre: "Rock", isPlaying: false)
let song2 = Song(title: "Blinding Lights", artist: "The Weeknd", duration: 203, genre: "Pop", isPlaying: false)

// Создаем плейлист
let playlist = Playlist()
playlist.addSong(song1)
playlist.addSong(song2)

// Тестируем методы
print("Длительность плейлиста: \(playlist.getTotalDuration()) сек")
print("Поиск по Queen: \(playlist.findSongs(by: "Queen").count) песен")

print("Воспроизведение: \(playlist.playSong(title: "Bohemian Rhapsody"))")
print("Сейчас играет: \(playlist.getNowPlaying()?.title ?? "ничего")")

playlist.stopSong(title: "Bohemian Rhapsody")
print("После остановки: \(playlist.getNowPlaying()?.title ?? "ничего")")

playlist.removeSong(title: "Blinding Lights")
print("После удаления: \(playlist.getTotalDuration()) сек")
/* Task: 'Music Playlist'.
 -- Тесты плейлиста --
 Длительность плейлиста: 557.0 сек
 Поиск по Queen: 1 песен
 Воспроизведение: true
 Сейчас играет: Bohemian Rhapsody
 После остановки: ничего
 После удаления: 354.0 сек */
 
