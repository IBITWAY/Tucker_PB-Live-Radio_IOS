//
//  AppDelegate.swift
//  RockRadio
//
//  Created by Faraz Rasheed on 11/08/2020.
//  Copyright © 2020 IBITWAY. All rights reserved.
//

import UIKit
import AVFoundation
//import Firebase
import LGSideMenuController
import FRadioPlayer
import UserNotifications
//import Firebase
import FirebaseMessaging
import FirebaseCore
import FirebaseFirestore
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var socialArray = [[String:Any]]()
    let gcmMessageIDKey = "gcm.message_id"
    
    // CarPlay
    var playableContentManager: MPPlayableContentManager?
    
    class func sharedInstance ()-> AppDelegate?{
        let sharedInstance = {
            UIApplication.shared.delegate as! AppDelegate
        }()
        return sharedInstance;
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        let audioSession = AVAudioSession.sharedInstance()
        //        do {
        //            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.moviePlayback)
        //            application.beginReceivingRemoteControlEvents()
        //        }
        //        catch {
        //            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        //        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }
        
        FirebaseApp.configure()
        
        let pushManager = PushNotificationManager(userID: "\(UIDevice.current.identifierForVendor!.uuidString)")
        pushManager.registerForPushNotifications()

//#if CarPlay
        setupCarPlay()
//#endif
        
        //        let viewController = MainViewController(nibName: "MainViewController", bundle: nil)
        //        self.window?.rootViewController = viewController
        
        //        Messaging.messaging().delegate = self
        //
        //        if #available(iOS 10.0, *) {
        //          // For iOS 10 display notification (sent via APNS)
        //          UNUserNotificationCenter.current().delegate = self
        //
        //          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        //          UNUserNotificationCenter.current().requestAuthorization(
        //            options: authOptions,
        //            completionHandler: {_, _ in })
        //        } else {
        //          let settings: UIUserNotificationSettings =
        //          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        //          application.registerUserNotificationSettings(settings)
        //        }
        //
        //        application.registerForRemoteNotifications()
        
        self.moveToHomeView()
        
        return true
    }
    
    func moveToHomeView(){
        let viewController = self.configureSideMenu(viewController: MainViewController())
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
    
    func moveToSideMenu() {
        let viewController = SideMenuController(nibName: "SideMenuController", bundle: nil)
        self.window?.rootViewController = viewController
    }
    
    func configureSideMenu(viewController: UIViewController)-> UIViewController {
        
        let contentController = SideMenuController(nibName: "SideMenuController", bundle: nil)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let sideMenuController = LGSideMenuController(rootViewController: navigationController,
                                                      leftViewController: contentController,
                                                      rightViewController: nil)
        
        sideMenuController.leftViewWidth = UIScreen.main.bounds.width - 100;
        sideMenuController.leftViewPresentationStyle = .slideAbove
        sideMenuController.leftViewAnimationDuration = 0.6
        sideMenuController.isLeftViewSwipeGestureEnabled = false
        sideMenuController.isRightViewSwipeGestureEnabled = false
        return sideMenuController
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //        application.beginReceivingRemoteControlEvents()
        //        let viewController = window?.rootViewController as! StationPlayerViewController
        //        viewController.disconnectAVPlayer()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        //        application.beginReceivingRemoteControlEvents()
        //        let viewController = window?.rootViewController as! StationPlayerViewController
        //        viewController.reconnectAVPlayer()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        super.remoteControlReceived(with: event)
        
        guard let event = event, event.type == .remoteControl else { return }
        
        switch event.subtype {
        case .remoteControlPlay:
            FRadioPlayer.shared.play()
        case .remoteControlPause:
            FRadioPlayer.shared.pause()
        case .remoteControlTogglePlayPause:
            FRadioPlayer.shared.togglePlaying()
        case .remoteControlNextTrack:
            break
            //            stationsViewController?.didPressNextButton()
        case .remoteControlPreviousTrack:
            break
            //            stationsViewController?.didPressPreviousButton()
        default:
            break
        }
    }
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([[.alert, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
}
