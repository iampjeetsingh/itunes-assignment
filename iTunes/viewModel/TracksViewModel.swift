//
//  ViewModel.swift
//  iTunes
//
//  Created by Paramjeet on 26/04/23.
//

import Foundation

class TracksViewModel : NSObject {
    private let trackService: TrackService
    
    private(set) var tracks : [Track]! {
        didSet {
            self.bindTracksViewModelToController()
        }
    }
    
    var bindTracksViewModelToController : (() -> ()) = {}
    
    override init() {
        self.trackService = TrackService()
    }
    
    func fetchTracks() {
        trackService.fetchTracks() { (trackResonse, error) in
            if error != nil {
                print(error)
            }else{
                self.tracks = self.filterTracks(tracks: trackResonse?.results)
            }
        }
    }
    
    func filterTracks(tracks: [Track]?) -> [Track] {
        var newTracks : [Track] = []
        if let safeTracks = tracks {
            for track in safeTracks {
                if track.wrapperType=="track" {
                    newTracks.append(track)
                }
            }
        }
        return newTracks
    }
}
