//
//  ViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/28.
//

import Foundation

extension Const {
    
    struct ViewController {
        
        struct Identifier {
            static let tabbar = "TabbarViewController"
            
            // Auth
            static let login = "LoginViewController"
            static let emailLogin = "EmailLoginViewController"
            static let signUpFirst = "SignUpFirstViewController"
            static let signUpSecond = "SignUpSecondViewController"
            static let signUpThird = "SignUpThirdViewController"
            static let findPassword = "FindPasswordViewController"
            static let code = "CodeViewController"
            static let newPassword = "NewPasswordViewController"

            // 홈 탭
            static let home = "HomeViewController"
            static let medal = "MedalViewController"
            static let setting = "SettingViewController"
            static let notification = "NotificationViewController"
            
            // 챌린지 탭
            static let emptyChallenge = "EmptyChallengeViewController"
            static let challenge = "ChallengeViewController"
            static let course = "CourseViewController"
            static let courseLibrary = "CourseLibraryViewController"
            
            // 피드 탭
            static let feed = "FeedViewController"
            static let myDrawer = "MyDrawerViewController"
            static let feedDetail = "FeedDetailViewController"
            static let writing = "WritingViewController"
            static let mood = "MoodViewController"
        }
    }
}