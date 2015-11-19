//
//  AppDelegate.swift
//  P.I.G
//
//  Created by Henrique do Prado Linhares on 20/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        
        let tabBarController = UITabBarController()
        let highRiskInvestmentsVC = HighRiskInvestmentsVC()
        let lowRiskInvestmentsVC = LowRiskInvestmentsVC()
        let propertiesVC = PropertiesVC()
        let goalsTipsVC = GoalsVC()
        
        let controllers = [highRiskInvestmentsVC, lowRiskInvestmentsVC, propertiesVC, goalsTipsVC]
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
        
        highRiskInvestmentsVC.tabBarItem = UITabBarItem(
            title: "High Risk",
            image: nil,
            tag: 1)
        lowRiskInvestmentsVC.tabBarItem = UITabBarItem(
            title: "Low Risk",
            image: nil,
            tag:2)
        
        propertiesVC.tabBarItem = UITabBarItem(
            title: "Properties",
            image: nil,
            tag:3)
        

        goalsTipsVC.tabBarItem = UITabBarItem(
            title: "Goals & Tips",
            image: nil,
            tag:4)
        
        
        if (PListManager.sharedInstance.databaseExists()){ // If Database exists
            //read database
            PlayerDAO.sharedInstance.readPlayer()
            EnterprisesDAO.sharedInstance.readEnterprises()
            TimerDAO.sharedInstance.readTimer()
        } else {
            // if database dont exists, create a new database
            PlayerDAO.sharedInstance.savePlayer()
            EnterprisesDAO.sharedInstance.saveEnterprises()
            TimerDAO.sharedInstance.saveTimer()
            PListManager.sharedInstance.writePlist("Database", key: "databaseExists", data: true)
        }
        
        
        AppData.sharedInstance.timer.startUpdates()
        application.statusBarHidden = true
        
        //EnterpriseValueUpdater().updateAllEnterprises()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        PlayerDAO.sharedInstance.savePlayer()
        EnterprisesDAO.sharedInstance.saveEnterprises()
        TimerDAO.sharedInstance.saveTimer()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        PlayerDAO.sharedInstance.savePlayer()
        EnterprisesDAO.sharedInstance.saveEnterprises()
        TimerDAO.sharedInstance.saveTimer()
    }


}

