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
    
    //MARK: - Var
    
    var video: Video
    var lessons: [Video]
     
    var videoView = UIView()
    var avpController = AVPlayerViewController()
    
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var nextButton = UIButton(type: .system)
    var downloadButton = UIButton()
    var downloadTask: URLSessionDownloadTask?
    
    init(video: Video, lessons: [Video]) {
        self.video = video
        self.lessons = lessons
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewComponents()
        AppDelegate.orientationLock = .all
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        setupDownloadButton()
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AppDelegate.orientationLock = .portrait
    }
    
    //MARK: - set/update
    
    private func setViewComponents() {
        setupVideoView()
        startVideo()
        if (UIDevice.current.orientation.isLandscape) {
            nameLabel.removeFromSuperview()
            descriptionLabel.removeFromSuperview()
            nextButton.removeFromSuperview()
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            setupNameLabel()
            descriptionLabel.frame = CGRect(x: 16, y: (nameLabel.frame.maxY) + 16,
                                            width: UIScreen.main.bounds.width - 32, height: 200)
            descriptionLabel.text = video.description
            descriptionLabel.textColor = .white
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            setupNextButton()
            view.addSubview(nameLabel)
            view.addSubview(descriptionLabel)
            view.addSubview(nextButton)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func updateUI() {
        setViewComponents()
        setupDownloadButton()
        view.setNeedsLayout()
        view.setNeedsDisplay()
    }

    //MARK: - Download
    
    private func setupDownloadButton() {
        downloadButton = UIButton(type: .system)
        downloadButton.addTarget(self, action: #selector(download), for: .touchUpInside)
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 4
        downloadButton.configuration = configuration
        
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: downloadButton)
        
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let videoDirectory = cacheDirectory.appendingPathComponent("videa")
            let videoURL = videoDirectory.appendingPathComponent("\(video.id).mp4")
            
            if FileManager.default.fileExists(atPath: videoURL.path) {
                downloadButton.setImage(UIImage(systemName: "checkmark.icloud"), for: .normal)
                downloadButton.setTitle("Downloaded", for: .normal)
                self.downloadButton.isEnabled = false
            } else {
                downloadButton.setTitle("Download", for: .normal)
                downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
                self.downloadButton.isEnabled = true
            }
        } else {
            downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        }
        downloadButton.sizeToFit()
    }
    
    @objc private func download() {
        downloadButton.setTitle("Downloading...", for: .normal)
        downloadButton.isEnabled = false
        
        let session = URLSession.shared
        downloadTask = session.downloadTask(with: URL(string: video.video_url)!) { [weak self] (tempURL, response, error) in
            if let tempURL = tempURL {
                
                if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
                    let videoDirectory = cacheDirectory.appendingPathComponent("videa")
                    do {
                        try FileManager.default.createDirectory(at: videoDirectory,
                                                                withIntermediateDirectories: true, attributes: nil)
                        let destinationURL = videoDirectory.appendingPathComponent("\(self!.video.id).mp4")
                        try FileManager.default.moveItem(at: tempURL, to: destinationURL)
                    } catch {
                        print(error)
                        self?.downloadButton.isEnabled = true
                    }
                }
            } else if let error = error {
                print(error)
                self?.downloadButton.isEnabled = true
            }
            
            DispatchQueue.main.async {
                self?.downloadButton.setTitle("Downloaded", for: .normal)
                self?.downloadButton.setImage(UIImage(systemName: "checkmark.icloud"), for: .normal)
                self?.downloadButton.isEnabled = false
            }
        }
        
        downloadTask?.resume()
    }

    //MARK: - NextButton

    private func setupNextButton() {
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
    
    //MARK: - NameLabel
    
    private func setupNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        nameLabel.frame = CGRect(x: 16, y: UIScreen.main.bounds.height / 3.6,
                                 width: UIScreen.main.bounds.width - 32, height: 28)
        nameLabel.text = video.name
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
    }
    
    //MARK: - Video
    
    private func setupVideoView() {
        videoView = UIView()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoView)
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: view.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoView.heightAnchor.constraint(equalTo: view.heightAnchor,
                                              multiplier: UIDevice.current.orientation.isLandscape ? 1 : 0.3)
        ])
    }
    
    private func startVideo() {
        if let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let videoDirectory = cacheDirectory.appendingPathComponent("videa")
            let videoURL = videoDirectory.appendingPathComponent("\(video.id).mp4")
            
            if FileManager.default.fileExists(atPath: videoURL.path) {
                let player = AVPlayer(url: videoURL)
                avpController.player = player
                avpController.entersFullScreenWhenPlaybackBegins = true
                addChild(avpController)
                avpController.view.frame = videoView.bounds
                videoView.addSubview(avpController.view)
                avpController.didMove(toParent: self)
                player.play()
            } else if let videoURL = URL(string: video.video_url) {
                let player = AVPlayer(url: videoURL)
                avpController.player = player
                avpController.entersFullScreenWhenPlaybackBegins = true
                addChild(avpController)
                avpController.view.frame = videoView.bounds
                videoView.addSubview(avpController.view)
                avpController.didMove(toParent: self)
                player.play()
            } else {
                print("Neplatná URL videa")
            }
        }
    }
    
}



