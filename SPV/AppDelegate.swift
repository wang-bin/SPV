//
//  AppDelegate.swift
//  SPV
//
//  Created by WangBin on 2021/4/4.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    var files = [String]()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        /*
        logLevel = .All
        setLogHandler { (level, msg) in
            print("\(level): " + msg)
        }
         */
        setGlobalOption(name: "MDK_KEY", value: "529809C623F1BF3CF6EA1185CE26D58FE00080C9352A743D65BA55968C1F3CAE16325E5B02B0CF466C474EA0E9305DF02A3D2EDA4CA0EFD2F03EA4D47011980CAD67F639DC0E40C30915EE7A31D92A70E00093AA5A475A5000DE3CF7E87A4AC57F46700852E6CD518320D3192631050388510E945A9E57E4931461ABED46980C")
        // Insert code here to initialize your application
        guard let vc = NSApp.windows.first?.contentViewController else {
            return
        }
        NSApp.windows.first?.makeFirstResponder(vc)
        //NSApp.windows.first?.makeKeyAndOrderFront(self)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    func application(_ sender: NSApplication, openFile filename: String) -> Bool {
        guard let vc = NSApp.windows.first?.contentViewController as? ViewController else {
            return false
        }
        vc.play(file: filename)
        return true
    }
    
    @IBAction func openDocument(_ sender: AnyObject) {
        guard let vc = NSApp.windows.first?.contentViewController as? ViewController else {
            return
        }
        let panel = NSOpenPanel()
        panel.title = "Choose Media File"
        panel.canCreateDirectories = false
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = true
        if panel.runModal() == .OK {
            for url in panel.urls {
                NSDocumentController.shared.noteNewRecentDocumentURL(url)
            }
            vc.play(file: panel.url!.path)
        }
    }
}

