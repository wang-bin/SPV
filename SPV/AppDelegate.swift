//
//  AppDelegate.swift
//  SPV
//
//  Created by 王斌 on 2021/4/4.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    var files = [String]()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if files.isEmpty {
            return
        }
        guard let vc = NSApplication.shared.windows.first?.contentViewController as? ViewController else {
            return
        }
        vc.play(file: files.first!)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        files = [String]()
        files.append(filename)
        return true
    }
}

