//
//  AppDelegate.swift
//  SPV
//
//  Created by WangBin on 2021/4/4.
//

import Cocoa
import SPVBase

@main
class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    var files = [String]()

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        logLevel = .All

        // Insert code here to initialize your application
        guard let win = NSApp.windows.first else {return}
        guard let vc = win.contentViewController else {
            return
        }
        win.makeFirstResponder(vc)
        //NSApp.windows.first?.makeKeyAndOrderFront(self)
        win.delegate = self
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

    /*
    func windowDidChangeScreen(_ notification: Notification) {
        let win = notification.object as! NSWindow
        guard let screen = win.screen else {return}
        guard let vc = win.contentViewController as? ViewController else {return}
        vc.updateHdr(screen)
    }*/

    func windowDidChangeScreenProfile(_ notification: Notification) {
        let win = notification.object as! NSWindow
        guard let screen = win.screen else {return}
        guard let vc = win.contentViewController as? ViewController else {return}
        vc.updateHdr(screen)
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
