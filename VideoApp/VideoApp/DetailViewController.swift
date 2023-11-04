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
    var lessons: [Video]
    
    var videoView: UIView!
    var avpController = AVPlayerViewController()
    
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var nextButton = UIButton(type: .system)
    
    
    init(video: Video, lessons: [Video]) {
        self.video = video
        self.lessons = lessons
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupVideoView() {
        videoView = UIView()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoView)
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: UIDevice.current.orientation.isLandscape ? 1 : 0.3)
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
        setViewComponents()
        AppDelegate.orientationLock = .all
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppDelegate.orientationLock = .portrait
    }
    
    @objc private func pressed() {
        if let currentIndex = lessons.firstIndex(where: { $0.id == video.id }), currentIndex < lessons.count - 1 {
            let nextVideo = lessons[currentIndex + 1]
            video = nextVideo
        } else if let firstVideo = lessons.first {
            video = firstVideo
        }
        updateUI()
    }
    
    func setViewComponents() {
        setupVideoView()
        startVideo()
        if (UIDevice.current.orientation.isLandscape) {
            nameLabel.removeFromSuperview()
            descriptionLabel.removeFromSuperview()
            nextButton.removeFromSuperview()
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            nameLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
            nameLabel.frame = CGRect(x: 16, y: UIScreen.main.bounds.height / 3.6, width: UIScreen.main.bounds.width - 32, height: 28)
            nameLabel.text = video.name
            nameLabel.textColor = .white
            nameLabel.numberOfLines = 0
            nameLabel.sizeToFit()
            
            descriptionLabel.frame = CGRect(x: 16, y: (nameLabel.frame.maxY) + 16, width: UIScreen.main.bounds.width - 32, height: 200)
            descriptionLabel.text = video.description
            descriptionLabel.textColor = .white
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            
            nextButton.setTitle("Next", for: .normal)
            nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 2
            nextButton.configuration = configuration
            nextButton.sizeToFit()
            nextButton.frame.origin.x = descriptionLabel.frame.maxX - nextButton.frame.width
            nextButton.frame.origin.y = descriptionLabel.frame.maxY + 16
            nextButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            view.addSubview(nameLabel)
            view.addSubview(descriptionLabel)
            view.addSubview(nextButton)
            self.navigationController?.setNavigationBarHidden(false, animated: true)

        }
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI()
       
    }
    
    func updateUI() {
        setViewComponents()
        view.setNeedsLayout()
        view.setNeedsDisplay()
    }
    
    
}



