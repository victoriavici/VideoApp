//
//  DetailViewController.swift
//  VideoApp
//
//  Created by Victoria Galikova on 03/11/2023.
//
import UIKit
import AVKit
import AVFoundation

class DetailViewController: UIViewController {
    var video: Video
    var videoView: UIView!
    var avpController = AVPlayerViewController()
    var videoViewHeightConstraint: NSLayoutConstraint!
    
    var nameLabel : UILabel?
    var descriptionLabel : UILabel?
    
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupVideoView() {
        videoView = UIView()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoView)

        videoViewHeightConstraint = videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: UIDevice.current.orientation.isLandscape ? 1.0 : 0.3)
                videoViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          
        ])
    }

    func startVideo() {
        if let videoURL = URL(string: video.video_url) {
            let player = AVPlayer(url: videoURL)
            avpController.player = player
            avpController.entersFullScreenWhenPlaybackBegins = true
            addChild(avpController)
            avpController.view.frame = videoView.bounds
            videoView.addSubview(avpController.view)
            avpController.didMove(toParent: self)
            player.play()
        } else {
            print("Invalid video URL")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoView()
        startVideo()
        
        nameLabel = UILabel()
        nameLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        nameLabel?.frame = CGRect(x: 16, y: UIScreen.main.bounds.height / 3.6, width: UIScreen.main.bounds.width - 24, height: 28)
        nameLabel?.text = video.name
        nameLabel?.textColor = .white
        nameLabel?.numberOfLines = 0
        nameLabel?.sizeToFit()
        
        view.addSubview(nameLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel?.frame = CGRect(x: 16, y: (nameLabel?.frame.maxY)! + 16, width: UIScreen.main.bounds.width - 24, height: 200)
        descriptionLabel?.text = video.description
        descriptionLabel?.textColor = .white
        descriptionLabel?.numberOfLines = 0
        descriptionLabel?.sizeToFit()
        
        view.addSubview(descriptionLabel!)

        
    
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape {
                    videoViewHeightConstraint.isActive = false
                    videoViewHeightConstraint = videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0)
                    videoViewHeightConstraint.isActive = true
                } else {
                    videoViewHeightConstraint.isActive = false
                    videoViewHeightConstraint = videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
                    videoViewHeightConstraint.isActive = true
                }
    }
}
