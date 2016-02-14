//
//  Main.swift
//  AirportJam
//
//  Created by Steve Richey on 2/12/16.
//  Copyright © 2016 STVR. All rights reserved.
//

import Cocoa
import SpriteKit
import Foundation

let windowWidth = 800
let windowHeight = 600
let title = "Airport Jam"

func make_window(width width: Int, height: Int, title: String) -> NSWindow {
    let window = NSWindow()
    let size = NSSize(width: width, height: height)
    window.setContentSize(size)
    window.styleMask = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask
    window.opaque = false
    window.center()
    window.title = title
    window.makeKeyAndOrderFront(window)
    window.level = 1
    return window
}

func make_view(width width: Int, height:Int) -> SKView {
    let view = SKView()

    view.frame = NSRect(x: 0, y: 0, width: width, height: height)
    view.ignoresSiblingOrder = true
    view.showsFPS = true
    view.showsNodeCount = true
    view.showsDrawCount = true

    return view
}

func on_mouse_down(scene: SKScene, event: NSEvent) {
    let location = event.locationInNode(scene)
    let sprite = SKSpriteNode(color: NSColor.blueColor(), size: CGSize(width: 10, height: 10))
    sprite.position = location;
    sprite.setScale(0.5)

    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
    sprite.runAction(SKAction.repeatActionForever(action))

    scene.addChild(sprite)
}

func make_scene() -> GameScene {
    let scene = GameScene()
    scene.scaleMode = .ResizeFill
    scene.backgroundColor = NSColor.redColor()
    scene.onDown = on_mouse_down
    return scene
}

class GameScene: SKScene {
    var onDown:((SKScene, NSEvent) -> Void)?

    override func mouseDown(theEvent: NSEvent) {
        onDown?(self, theEvent)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    let window = make_window(width: windowWidth, height: windowHeight, title: title)
    let scene = make_scene()
    let view = make_view(width: windowWidth, height: windowHeight)

    func applicationDidFinishLaunching(notification: NSNotification) {
        view.presentScene(scene)
        window.contentView?.addSubview(view)
    }

    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}

autoreleasepool {
    let app = NSApplication.sharedApplication()
    app.setActivationPolicy(.Regular)

    let controller = AppDelegate()

    app.delegate = controller
    app.run()
}
