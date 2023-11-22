//
//  MainViewController.swift
//  RockRadio
//
//  Created by Sheraz Rasheed on 11/08/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import UserNotifications
import FRadioPlayer
//import Firebase
import FirebaseFirestore
import FirebaseStorage
import SDWebImage
//import SwiftGifOrigin
import Alamofire
import SwiftyJSON
import CarPlay

var radioStationURL = String()

class MainViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet var albumCoverImage: UIImageView!
    @IBOutlet var gifImageView: UIImageView!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var volumeController: UISlider!
    @IBOutlet weak var currentSongLabel: UILabel!
    @IBOutlet weak var radioInformation: UILabel!
    
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var slideHandle: UIButton!
    
    @IBOutlet weak var airPlayButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var playerImageView: UIView!
    
    var stationObject = [[String:Any]]()
    var adsArray = [[String:Any]]()
    var socialArray = [[String:Any]]()

    weak var timer: Timer?
    var adObject = [String : Any]()
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var adImageView: UIImageView!


    var lastImageUrl = ""
    
    //    var player: AVPlayer?
    let player: FRadioPlayer = FRadioPlayer.shared
    let stations = [Station(name: appName,
                            detail: "Are you ready to Folk?",
                            url: URL(string: radioURL)!,
                            image: #imageLiteral(resourceName: "VibeFavicon"))]
    
    var selectedIndex = 0 {
        didSet {
            defer {
                selectStation(at: selectedIndex)
                updateNowPlaying(with: track)
            }
            
            guard 0..<stations.endIndex ~= selectedIndex else {
                selectedIndex = selectedIndex < 0 ? stations.count - 1 : 0
                return
            }
        }
    }
    
    var track: Track? {
        didSet {
            currentSongLabel.text = (track?.artist ?? "")
            //                + " - " + (track?.name ?? "")
            radioInformation.text = track?.name
            updateNowPlaying(with: track)
        }
    }
    
    var playerItem: AVPlayerItem?
    var playerViewcontroller = AVPlayerViewController()
    var nowPlayingInfo = [String: Any]()
    var isPlaying = false
    var gradientLayer = CAGradientLayer()
    
    var result: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.adsData()

        self.socialData()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = true
        
        player.delegate = self
        selectedIndex = 0
        player.volume = 100
        
        addGradientLayer()
        setNeumorphicButtons()
        setupPlayerView()
        setupHandleRadialLayer()
        
        player.delegate = self
        player.play()
//        let audioSession = AVAudioSession.sharedInstance()
//        do{
//            try audioSession.setCategory(AVAudioSession.Category.playback)
//        }
//        catch{
//            fatalError("playback failed")
//        }
        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//            print("Playback OK")
//            try AVAudioSession.sharedInstance().setActive(true)
//            print("Session is Active")
//        } catch {
//            print(error)
//        }
        
        self.setupRemoteTransportControls()
        
//        self.albumCoverImage.image = UIImage.gif(name: "ezgif")
        
        Timer.scheduledTimer(timeInterval: 10,
                             target: self,
                             selector: #selector(execute),
                             userInfo: nil,
                             repeats: true)
    }
    
    @objc func execute() {
//        self.apiCall()
    }

    
    override func viewDidLayoutSubviews() {
        self.setupPlayerView()
    }
    
    func refreshData() {
        
        Firestore.firestore().collection("stations").getDocuments { (documentSnapshot, error) in
            if let err = error{
                print("Error getting documents: \(err)")
            }else{
                for document in documentSnapshot!.documents {
                    let data = document.data()
                    self.stationObject.append(data)
                }
                self.selectStation(at: self.selectedIndex)
                self.adsData()
            }
        }
    }
    
    func adsData() {
        
        Firestore.firestore().collection("ads").getDocuments { (documentSnapshot, error) in
            if let err = error{
                print("Error getting documents: \(err)")
            }else{
                for document in documentSnapshot!.documents {
                    let data = document.data()
                    self.adsArray.append(data)
                }
                
                self.startTimer()
                
                self.socialData()
            }
        }
    }
    
    func socialData() {
        
        Firestore.firestore().collection("social").getDocuments { (documentSnapshot, error) in
            if let err = error{
                print("Error getting documents: \(err)")
            }else{
                for document in documentSnapshot!.documents {
                    let data = document.data()
                    
                    if let isRadio = data["isRadio"] as? Bool {
                        if isRadio {
                            if let url = data["stream"] as? String {
                                radioURL = url
                            }
                        }
                    }

                    if let name = data["name"] as? String {
                        if name == "Instagram" {
                            if let url = data["stream"] as? String {
                                instaUrl = url
                            }
                        }
                        
                        if name == "Facebook" {
                            if let url = data["stream"] as? String {
                                facebookUrl = url
                            }
                        }

                        
                        if name == "Twitter" {
                            if let url = data["stream"] as? String {
                                twitterUrl = url
                            }
                        }

                        
                        if name == "Website" {
                            if let url = data["stream"] as? String {
                                websiteUrl = url
                            }
                        }

                        if name == "Email" {
                            if let url = data["stream"] as? String {
                                email = url
                            }
                        }

                        if name == "Schedule" {
                            if let url = data["stream"] as? String {
                                schedule = url
                            }
                        }

                        if name == "Contact Us" {
                            if let url = data["stream"] as? String {
                                contact_us = url
                            }
                        }

                    }

                    self.socialArray.append(data)
                    
                    
                }
                
                AppDelegate.sharedInstance()?.socialArray = self.socialArray
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        var selectedIndex = 0
        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            
            if (self?.adsArray.count ?? 0) > selectedIndex {
                
                if let adObject = self?.adsArray[selectedIndex] {
                    self!.updateAdsUI(ad: adObject)
                }
                
                
                selectedIndex = selectedIndex + 1
            }else {
                selectedIndex = 0
            }
        }
    }
    
    func updateAdsUI(ad: [String : Any]) {
        
        self.adView.isHidden = false
        self.adObject = ad
        
        if let imageURl = ad["image"] as? String {
//            let placeholderImage = UIImage(named: "banner_demo")!
            self.adImageView.sd_setImage(with: URL(string: imageURl))
//            sd_setImage(with: URL(string: imageURl), placeholderImage: placeholderImage)
        }
        
    }
    
    @IBAction func openAdButtonTapped(_ sender: Any) {
        
        if let webURl = self.adObject["url"] as? String {
            open(scheme: webURl)
        }
        
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    func addGradientLayer() {
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.lightBlack.cgColor, UIColor.darkBlack.cgColor]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    fileprivate func setupHandleRadialLayer() {
        let radialGradient = CAGradientLayer()
        radialGradient.type = .radial
        radialGradient.frame = slideHandle.bounds
        radialGradient.colors = [
            UIColor.tickYellow.withAlphaComponent(0.7).cgColor,
            UIColor.tickYellow.cgColor,
            UIColor.darkText.cgColor,
            UIColor.darkBlack.cgColor,
        ]
        
        radialGradient.locations = [0, 0.32, 0.32, 1.0]
        
        radialGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        radialGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        radialGradient.cornerRadius = slideHandle.bounds.height / 2.0
        
        slideHandle.layer.cornerRadius = slideHandle.bounds.height / 2.0
        slideHandle.layer.insertSublayer(radialGradient, at: 0)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(slidePanGesture))
        slideHandle.addGestureRecognizer(panGestureRecognizer)
        
        slideHandle.makeOutwardNeomorphic(reversed: false, offsetValue: 4.0, cornerRadius: slideHandle.bounds
            .height / 2.0, shadowRadius: 4.0, alphaLight: 0.1, alphaDark: 0.1)
        
    }
    
    var currentPosition: CGFloat = 0.0
    
    @objc func slidePanGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: slideHandle).x
        
        let nextPosition = translation + self.currentPosition
        
        let offset = CGFloat(18.0)
        
        let threshHold = offset...(slideView.frame.width - offset)
        
        print("threshHold: \(threshHold)")
        
        switch gesture.state {
            
        case .changed:
            
            if threshHold.contains(nextPosition) {
                UIView.animate(withDuration: 0.2, animations: {
                    self.slideHandle.center.x = nextPosition
                }) { (value) in
                    self.view.layoutIfNeeded()
                }
            }
            
            print("threshHold: \(threshHold)")
            
        case .ended:
            
            if nextPosition < offset {
                currentPosition = offset
            } else if nextPosition > slideView.frame.width - offset {
                currentPosition = slideView.frame.width - offset
            } else {
                currentPosition += translation
            }
            print("currentPosition: \(currentPosition / slideView.frame.width)")
            
            player.volume = Float(currentPosition / slideView.frame.width)
            
        default:
            break
        }
        
    }
    
    fileprivate func setupPlayerView() {
//        playerImageView.backgroundColor = UIColor.darkBlack
        playerImageView.layer.cornerRadius = playerImageView.bounds.width / 2.0
//            playerImageView.bounds.width / 2.0
        
//        playerImageView.makeOutwardNeomorphic(reversed: false, offsetValue: 15.0, shadowRadius: 15.0, alphaLight: 0.1, alphaDark: 0.2)
        
//        albumCoverImage.contentMode = .scaleToFill
        albumCoverImage.layer.cornerRadius = 10
//        albumCoverImage.bounds.width / 2.0
//            albumCoverImage.bounds.width / 2.0
//        albumCoverImage.layer.masksToBounds = true
    }
    
    func selectStation(at position: Int) {
        player.radioURL = URL(string: radioURL)

//        if self.stationObject.count > 0 {
//            player.radioURL = URL(string: self.stationObject[selectedIndex]["stream_url"] as! String)
//            updateNowPlaying(with: track)
//        }
    }
    
    fileprivate func setNeumorphicButtons() {
        
        [backButton, menuButton, shareButton, airPlayButton, playButton].forEach { (button) in
            
            if let thisButton = button, thisButton == playButton {
                performBaseButtonFunctions(button: thisButton, startColor: .mellowOrange, endColor: .mellowOrange)
                
                thisButton.makeOutwardNeomorphic(reversed: true, offsetValue: 1.0, cornerRadius: menuButton.bounds.height / 2.0, shadowRadius: 1.0, alphaLight: 0.05, alphaDark: 0.1)
                
                thisButton.tintColor = .white
                
                if let image = thisButton.imageView {
                    thisButton.bringSubviewToFront(image)
                }
                
                thisButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                
                self.view.layoutIfNeeded()
                
            } else {
                performBaseButtonFunctions(button: button)
                
                button?.makeOutwardNeomorphic(reversed: true, offsetValue: 3.0, cornerRadius: menuButton.bounds.height / 2.0, shadowRadius: 3.0, alphaLight: 0.1, alphaDark: 0.4)
                
                if let image = button?.imageView {
                    button?.bringSubviewToFront(image)
                }
            }
            
        }
    }
    
    fileprivate func performBaseButtonFunctions(button: UIButton?, startColor: UIColor = UIColor.lightBlack, endColor: UIColor = UIColor.darkBlack) {
        
        guard let thisButton = button else {return}
        
        thisButton.layer.cornerRadius = backButton.bounds.height / 2.0
        
        let buttonGradient = CAGradientLayer()
        buttonGradient.frame = thisButton.bounds
        buttonGradient.colors = [startColor.cgColor, endColor.cgColor]
        buttonGradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        buttonGradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        buttonGradient.cornerRadius = thisButton.bounds.height / 2.0
        
        thisButton.layer.insertSublayer(buttonGradient, at: 0)
        
    }
    
    func notifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, error in})
        
        let content = UNMutableNotificationContent()
        
        content.title = titleText
        content.body = messageText
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch event?.subtype {
        case UIEvent.EventSubtype.remoteControlPlay?:
            player.play()
            break
        case UIEvent.EventSubtype.remoteControlPause?:
            player.pause()
            break
        default:
            break
        }
    }
    @IBAction func playTap(_ sender: Any) {
        if player.isPlaying {
//            self.gifImageView.isHidden = true
//            player.stop()
            player.pause()
            playButton.setImage(UIImage(named: "play"), for: .normal)
        }else {
//            self.gifImageView.isHidden = false
            selectedIndex = 0
            player.togglePlaying()
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
    }
    
    @IBAction func stopTap(_ sender: Any) {
        player.stop()
    }
    @IBAction func changeVolume(_ sender: Any) {
        player.volume = volumeController.value
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let text = "Hello! I listen to the \(appName) 📲 https://apps.apple.com/us/app/vibe-103-fm-pro/id6471822681?platform=iphone\n\n"
        let shareAll = [text] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        if let popOver = activityViewController.popoverPresentationController {
          popOver.sourceView = self.view
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.popoverPresentationController?.sourceRect = (sender as AnyObject).frame
        }

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func airPlayButton(_ sender: Any) {
        showAirplay()
    }
    
    func showAirplay() {
        let rect = CGRect(x: -100, y: 0, width: 0, height: 0)
        let airplayVolume = MPVolumeView(frame: rect)
        airplayVolume.showsVolumeSlider = false
        self.view.addSubview(airplayVolume)
        for view: UIView in airplayVolume.subviews {
            if let button = view as? UIButton {
                button.sendActions(for: .touchUpInside)
                break
            }
        }
        airplayVolume.removeFromSuperview()
    }
    
    @IBAction func openSideMenu(_ sender: Any) {
        self.sideMenuController?.showLeftViewAnimated(sender: sender)
    }
}

extension MainViewController {
    
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player.rate == 0.0 {
                self.player.play()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.player.rate == 1.0 {
                self.player.pause()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Next Command
        commandCenter.nextTrackCommand.addTarget { [unowned self] event in
            
            return .success
        }
        
        // Add handler for Previous Command
        commandCenter.previousTrackCommand.addTarget { [unowned self] event in
            
            return .success
        }
    }
    
    func updateNowPlaying(with track: Track?) {
        
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        
        if let artist = track?.artist {
            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        }
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = track?.name ?? stations[selectedIndex].name
        
        if let image = track?.image ?? stations[selectedIndex].image {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { _ -> UIImage in
                DispatchQueue.main.async {
                    self.albumCoverImage.image = image
                }
                return image
            })
        }
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
//    func apiCall() {
//        Alamofire.request("https://unityliveradio.co.uk/wp-json/radio/broadcast/", method: .get, parameters: nil, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                print(response)
//                //to get status code
//                if let status = response.response?.statusCode {
//                    switch(status){
//                    case 201:
//                        print("example success")
//                    default:
//                        print("error with response status: \(status)")
//                    }
//                }
//                //to get JSON return value
//                if let result = response.result.value {
//                    let JSON = result as! NSDictionary
//                    
//                    if let broadcast = JSON["broadcast"] as? NSDictionary {
//                        if let current_show = broadcast["current_show"] as? NSDictionary {
//                            let day = (current_show["day"] as? String) ?? ""
//                            let end = (current_show["end"] as? String) ?? "N/A"
//                            let start = (current_show["start"] as? String) ?? "N/A"
//                            if let show = current_show["show"] as? NSDictionary {
//                                
//                                if let avatar_url = show["avatar_url"] as? String {
//  //                                  if self.lastImageUrl != avatar_url {
//                                        self.lastImageUrl = avatar_url
//                                        let placeholderImage = UIImage(named: "banner_demo")!
//                                        self.albumCoverImage.sd_setImage(with: URL(string: avatar_url), placeholderImage: placeholderImage)
////                                    }
//                                }
//
//                                if let name = show["name"] as? String {
////                                    self.currentSongLabel.text = "\(name)"
//                                    
//                                    self.radioInformation.text = "\(day) \(start) - \(end)"
//                                }
//                            }
//                        }
//                    }
//                    
//                    print(JSON)
//                }
//                
//        }
//    }
}

extension MainViewController: FRadioPlayerDelegate {
    
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        playButton.isSelected = player.isPlaying
        
        if player.isPlaying {
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        }else {
            playButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        track = Track(artist: artistName, name: trackName)
    }
    
    func radioPlayer(_ player: FRadioPlayer, itemDidChange url: URL?) {
        track = nil
    }
    
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange rawValue: String?) {
    }
    
    func radioPlayer(_ player: FRadioPlayer, artworkDidChange artworkURL: URL?) {
        
        // Please note that the following example is for demonstration purposes only, consider using asynchronous network calls to set the image from a URL.
        guard let artworkURL = artworkURL, let data = try? Data(contentsOf: artworkURL) else {
            albumCoverImage.image = stations[selectedIndex].image
            return
        }
        track?.image = UIImage(data: data)
        albumCoverImage.image = track?.image
        updateNowPlaying(with: track)
    }
}

