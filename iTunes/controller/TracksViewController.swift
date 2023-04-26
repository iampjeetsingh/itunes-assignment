//
//  ViewController.swift
//  iTunes
//
//  Created by Paramjeet on 26/04/23.
//

import UIKit

class TracksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TracksViewModel? = nil
    
    var tracks : [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        viewModel = TracksViewModel()
        
        viewModel?.bindTracksViewModelToController = {
            if let tracks = self.viewModel?.tracks {
                self.tracks = tracks
                self.tableView.reloadData()
            }
        }
        viewModel?.fetchTracks()
    }
}

extension TracksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let track = tracks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! TrackCell
        // load image
        if let artworkUrl = track.artworkUrl100, let pictureURL = URL(string: artworkUrl) {
            setImageFromStringrURL(stringUrl: artworkUrl, imageView: cell.artworkImage)
        }
        // Load data into label
        var text = ""
        if let trackName = track.trackName {
            text += "Track: \(trackName)\n"
        }
        if let artistName = track.artistName {
            text += "Artist: \(artistName)\n"
        }
        if let price = track.trackPrice, let currency = track.currency {
            text += "Price: \(price) \(currency)"
        }
        if let description = track.description {
            text += "Description: \(description)"
        }
        cell.label.text = text
        return cell
    }
    
    func setImageFromStringrURL(stringUrl: String, imageView: UIImageView) {
      if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          guard let imageData = data else { return }
          DispatchQueue.main.async {
              imageView.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

