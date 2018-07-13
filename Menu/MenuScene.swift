//
//  MenuScene.swift
//  BUMP
//
//  Created by Sebastian Revel on 11/25/17.
//  Copyright © 2017 Sebastian Revel. All rights reserved.
//
//imports/defines libraries to be used
import SpriteKit
import AVFoundation

class MenuScene: SKScene {
    //background textures downloaded from http://makepixelart.com/peoplepods/files/images/318656.original.png
    //declares variables to be used in main menu scene
    var startButton = SKSpriteNode()
    var title = SKLabelNode()
    //slime character designed by pixelsandthings from http://pixelsandthings.tumblr.com/post/21111849500
    var slimeOne = SKSpriteNode()
    //slime character designed by pixelsandthings from http://pixelsandthings.tumblr.com/post/21111849500
    var slimeTwo = SKSpriteNode()
    var startLabel = SKLabelNode()
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var tab = SKSpriteNode()
    var tab2 = SKSpriteNode()
    var tab3 = SKSpriteNode()
    var store = SKSpriteNode()
    var storeBack = SKSpriteNode()
    var tabStatus = false
    var blueGlove = SKSpriteNode()
    var redGlove = SKSpriteNode()
    var sword = SKSpriteNode()
    var baseballbat = SKSpriteNode()
    var gloveTag = SKSpriteNode()
    var swordTag = SKSpriteNode()
    var batTag = SKSpriteNode()
    var knifeTag = SKSpriteNode()
    var glovePrice = SKLabelNode()
    var swordPrice = SKLabelNode()
    var batPrice = SKLabelNode()
    var knifePrice = SKLabelNode()
    var knife = SKSpriteNode()
    var ownRedGlove = true
    var choseRedGlove = UserDefaults().bool(forKey: "choseRedGlove")
    var ownBlueGlove = UserDefaults().bool(forKey: "ownBlueGlove")
    var choseBlueGlove = UserDefaults().bool(forKey: "choseBlueGlove")
    var ownSword = UserDefaults().bool(forKey: "ownSword")
    var choseSword = UserDefaults().bool(forKey: "choseSword")
    var ownBat = UserDefaults().bool(forKey: "ownBat")
    var choseBat = UserDefaults().bool(forKey: "choseBat")
    var ownKnife = UserDefaults().bool(forKey: "ownKnife")
    var choseKnife = UserDefaults().bool(forKey: "choseKnife")
    var Spoints = SKLabelNode()
    var points = SKLabelNode()
    var loggedPoints = UserDefaults().integer(forKey: "POINTS")
    var check = SKSpriteNode()
    override func didMove(to view: SKView){
        //defines variables appropraitely
        points = self.childNode(withName: "points") as! SKLabelNode
        Spoints = self.childNode(withName: "Spoints") as! SKLabelNode
        startButton = self.childNode(withName: "startButton") as! SKSpriteNode
        title = self.childNode(withName: "title") as! SKLabelNode
        startLabel = self.childNode(withName: "startLabel") as! SKLabelNode
        slimeOne = self.childNode(withName: "slime1") as! SKSpriteNode
        slimeTwo = self.childNode(withName: "slime2") as! SKSpriteNode
        tab = self.childNode(withName: "tab") as! SKSpriteNode
        tab2 = self.childNode(withName: "tab2") as! SKSpriteNode
        tab3 = self.childNode(withName: "tab3") as! SKSpriteNode
        store = self.childNode(withName: "store") as! SKSpriteNode
        storeBack = self.childNode(withName: "storeBack") as! SKSpriteNode
        redGlove = self.childNode(withName: "redGlove") as! SKSpriteNode
        blueGlove = self.childNode(withName: "blueGlove") as! SKSpriteNode
        gloveTag = self.childNode(withName: "gloveTag") as! SKSpriteNode
        glovePrice = self.childNode(withName:"glovePrice") as! SKLabelNode
        //sword image taken from https://orig00.deviantart.net/2c11/f/2015/073/4/2/pixel_sword_by_m42ngc1976-d8ln5sx.png
        sword = self.childNode(withName: "sword") as! SKSpriteNode
        swordTag = self.childNode(withName:"swordTag") as! SKSpriteNode
        swordPrice = self.childNode(withName:"swordPrice") as! SKLabelNode
        //baseballbat image taken from https://pzwiki.net/w/images/8/80/Baseballbat.png
        baseballbat = self.childNode(withName: "baseballbat") as! SKSpriteNode
        batPrice = self.childNode(withName:"batPrice") as! SKLabelNode
        batTag = self.childNode(withName:"batTag") as! SKSpriteNode
        //knife image taken http://piq.codeus.net/static/media/userpics/piq_85503_400x400.png
        knife = self.childNode(withName: "knife") as! SKSpriteNode
        knifeTag = self.childNode(withName: "knifeTag") as! SKSpriteNode
        knifePrice = self.childNode(withName:"knifePrice") as! SKLabelNode
        check = self.childNode(withName: "check") as! SKSpriteNode
        points.text = "\(loggedPoints)"
        Spoints.text = "\(loggedPoints)"
        //animates the two main menu slimes for visual purposes
        animateNodes([slimeOne])
        animateNodes([slimeTwo])
        //runs necessary prerequisites to playing a song/sound
        do{
            //menu song from https://www.youtube.com/watch?v=RMaXfrgOT8s
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "menusong", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        //plays song when menuscene starts
        audioPlayer.play()
    }
    //checks touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        //if start button is touched, button will press inwards
        if startButton.contains(touch.location(in:self)){
            let push = SKAction.scale(by: 0.90, duration: 0.001)
            startButton.run(SKAction.repeat(push, count: 1))
            startLabel.run(SKAction.repeat(push, count: 1))
        }
        if tab.contains(touch.location(in: self)){
            //opens up the store tab
            if tabStatus == false{
                moveStoreUp()
                isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(260), execute: {
                    self.isUserInteractionEnabled = true
                })
            }
            //closes store tab
            else{
                moveStoreDown()
                isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(260), execute: {
                    self.isUserInteractionEnabled = true
                })
            }
        }
        //checks if user touched blueGlove
        if blueGlove.contains(touch.location(in: self)){
            //if user doesn't own the glove, it will check to see if the user has enough points to purchase it
            if ownBlueGlove == false{
                if loggedPoints >= 15{
                    check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -153, y: -615.0), duration: 0.001 ), count: 1))
                    loggedPoints -= 15
                    chaching()
                    //assigns all appropriate booleans after selection
                    ownBlueGlove = true
                    choseBlueGlove = true
                    choseRedGlove = false
                    choseBat = false
                    choseKnife = false
                    choseSword = false
                    UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                    UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                    UserDefaults.standard.set(choseSword, forKey: "choseSword")
                    UserDefaults.standard.set(choseBat, forKey: "choseBat")
                    UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
                    UserDefaults.standard.set(loggedPoints, forKey: "POINTS")
                    UserDefaults.standard.set(ownBlueGlove, forKey: "ownBlueGlove")
                    //runs purchase animations for tags
                    alreadyBought(node1: gloveTag, node2: glovePrice)
                }
                //if the user doesn't have enough points, it will run this animation
                else{
                    cantAfford([blueGlove])
                }
            }
            //if the user already owns the glove, it will move the check and assign the glove to the user
            else{
                check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -153, y: -615.0), duration: 0.001 ), count: 1))
                choseBlueGlove = true
                choseRedGlove = false
                choseBat = false
                choseKnife = false
                choseSword = false
                UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                UserDefaults.standard.set(choseSword, forKey: "choseSword")
                UserDefaults.standard.set(choseBat, forKey: "choseBat")
                UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
            }
        }
        //when user touches red glove, it will assign that icon to the player
        if redGlove.contains(touch.location(in: self)){
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -279, y: -615.0), duration: 0.001 ), count: 1))
            choseBlueGlove = false
            choseRedGlove = true
            choseBat = false
            choseKnife = false
            choseSword = false
            UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
            UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
            UserDefaults.standard.set(choseSword, forKey: "choseSword")
            UserDefaults.standard.set(choseBat, forKey: "choseBat")
            UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
            }
        //checks if user touched sword
        if sword.contains(touch.location(in: self)){
            //if user doesn't own the sword, it will check if they can afford it
            if ownSword == false{
                if loggedPoints >= 50{
                    check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -22, y: -615.0), duration: 0.0000001 ), count: 1))
                    loggedPoints -= 50
                    chaching()
                    //assigns all appropriate booleans after selection
                    ownSword = true
                    choseBlueGlove = false
                    choseRedGlove = false
                    choseBat = false
                    choseKnife = false
                    choseSword = true
                    UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                    UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                    UserDefaults.standard.set(choseSword, forKey: "choseSword")
                    UserDefaults.standard.set(choseBat, forKey: "choseBat")
                    UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
                    UserDefaults.standard.set(loggedPoints, forKey: "POINTS")
                    UserDefaults.standard.set(ownSword, forKey: "ownSword")
                    //runs purchase animations to tags
                    alreadyBought(node1: swordTag, node2: swordPrice)
                }
                else{
                    //if the user doesn't have enough points, it will run this animation
                    cantAfford([sword])
                }
            }
            //if user already owns the sword, it will move the check and assign the sword to the user
            else{
                check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -22, y: -615.0), duration: 0.0000001 ), count: 1))
                choseBlueGlove = false
                choseRedGlove = false
                choseBat = false
                choseKnife = false
                choseSword = true
                UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                UserDefaults.standard.set(choseSword, forKey: "choseSword")
                UserDefaults.standard.set(choseBat, forKey: "choseBat")
                UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
            }
        }
        //checks if user touched baseballbat
        if baseballbat.contains(touch.location(in: self)){
            //if user doesn't own the bat, it will check to see if they can afford it
            if ownBat == false{
                if loggedPoints >= 400{
                    check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 120, y: -615.0), duration: 0.0001 ), count: 1))
                    loggedPoints -= 400
                    chaching()
                    //assigns all appropriate booleans after selection
                    ownBat = true
                    choseBlueGlove = false
                    choseRedGlove = false
                    choseBat = true
                    choseKnife = false
                    choseSword = false
                    UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                    UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                    UserDefaults.standard.set(choseSword, forKey: "choseSword")
                    UserDefaults.standard.set(choseBat, forKey: "choseBat")
                    UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
                    UserDefaults.standard.set(loggedPoints, forKey: "POINTS")
                    UserDefaults.standard.set(ownBat, forKey: "ownBat")
                    //runs purchase animations for tags
                    alreadyBought(node1: batTag, node2: batPrice)
                }
                else{
                    //runs animation to indicate user cannot afford it
                    cantAfford([baseballbat])
                }
            }
            //if user already owns the bat, it will move the check and assign the bat to the user
            else{
                check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 120, y: -615.0), duration: 0.0001 ), count: 1))
                choseBlueGlove = false
                choseRedGlove = false
                choseBat = true
                choseKnife = false
                choseSword = false
                UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                UserDefaults.standard.set(choseSword, forKey: "choseSword")
                UserDefaults.standard.set(choseBat, forKey: "choseBat")
                UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
            }
        }
        //checks if user touched knife
        if knife.contains(touch.location(in: self)){
            //if user doesn't own the knife, it will check if the user can afford
            if ownKnife == false{
                if loggedPoints >= 1000{
                    check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 275, y: -615.0), duration: 0.0001 ), count: 1))
                    loggedPoints -= 1000
                    chaching()
                    //assigns all appropriate booleans after selection
                    ownKnife = true
                    choseBlueGlove = false
                    choseRedGlove = false
                    choseBat = false
                    choseKnife = true
                    choseSword = false
                    UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                    UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                    UserDefaults.standard.set(choseSword, forKey: "choseSword")
                    UserDefaults.standard.set(choseBat, forKey: "choseBat")
                    UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
                    UserDefaults.standard.set(loggedPoints, forKey: "POINTS")
                    UserDefaults.standard.set(ownKnife, forKey: "ownKnife")
                    //runs purchase animations for tags
                    alreadyBought(node1: knifeTag, node2: knifePrice)
                }
                else{
                    //runs animation to indicate user cannot afford it
                    cantAfford([knife])
                }
            }
            //if user already owns the knife, it will move the check and assign the knife to the user
            else{
                check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 275, y: -615.0), duration: 0.0001 ), count: 1))
                choseBlueGlove = false
                choseRedGlove = false
                choseBat = false
                choseKnife = true
                choseSword = false
                UserDefaults.standard.set(choseRedGlove, forKey: "choseRedGlove")
                UserDefaults.standard.set(choseKnife, forKey: "choseKnife")
                UserDefaults.standard.set(choseSword, forKey: "choseSword")
                UserDefaults.standard.set(choseBat, forKey: "choseBat")
                UserDefaults.standard.set(choseBlueGlove, forKey: "choseBlueGlove")
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //if touch is released on the start game button, transition into game scene
        if startButton.contains(touch.location(in:self)){
            let pull = SKAction.scale(by: 1.1, duration: 0.1)
            startButton.run(SKAction.repeat(pull, count: 1))
            startLabel.run(SKAction.repeat(pull, count: 1))
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150), execute: {
            let transition = SKTransition.fade(withDuration: 0.5)
            let gameScene = GameScene(fileNamed:"GameScene")
            gameScene?.scaleMode = .aspectFit
            self.view?.presentScene(gameScene!, transition: transition)
            })
        }
    }
    //runs the shrinking purchase animation
    func purchased(node: SKNode){
        let shrink = SKAction.scale(to: 0.0, duration: 0.1)
        node.run(SKAction.repeatForever(shrink))
    }
    //used to create the "breathing" oscillation scaling animation
    // function from (https://www.swiftbysundell.com/posts/using-spritekit-to-create-animations-in-swift)
    func animateNodes(_ nodes: [SKNode]){
        for (index, node) in nodes.enumerated(){
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    .scale(to: 1, duration: 0.3),
                    .scale(to: 1.25, duration: 0.3),
                    ]))
                ]))
        }
    }
    //a shakey animation to indicate the user cannot afford
    func cantAfford(_ nodes: [SKNode]){
        for (index, node) in nodes.enumerated(){
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeat(.sequence([
                    .rotate(byAngle: .pi/5, duration: 0.1),
                    .rotate(byAngle: -.pi/5, duration: 0.1)
                    ]), count: 3)
                ]))
        }
    }
    //animations for the pull up store opening as well as visually representing which items a user has purchased and equipped
    func moveStoreUp(){
        glovePrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -146.343, y: -615), duration: 0.25 ), count: 1))
        swordPrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -18.343, y: -615), duration: 0.25 ), count: 1))
        batPrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 125.343, y: -615), duration: 0.25 ), count: 1))
        knifePrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 271.343, y: -615), duration: 0.25 ), count: 1))
        gloveTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -187.343, y: -593), duration: 0.25 ), count: 1))
        swordTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -60.5, y: -593), duration: 0.25 ), count: 1))
        batTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 81.56, y: -593), duration: 0.25 ), count: 1))
        knifeTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 228.516, y: -593), duration: 0.25 ), count: 1))
        redGlove.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -289, y: -510), duration: 0.25 ), count: 1))
        blueGlove.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -151, y: -510), duration: 0.25 ), count: 1))
        baseballbat.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 130, y: -510), duration: 0.25 ), count: 1))
        sword.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -1, y: -500), duration: 0.25 ) , count: 1))
        knife.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 285, y: -510), duration: 0.25 ), count: 1))
        tab.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -56.108, y: -378.189), duration: 0.25 ), count: 1))
        tab2.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -56.108, y: -349), duration: 0.25 ), count: 1))
        tab3.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -56.108, y: -319), duration: 0.25 ), count: 1))
        store.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 0, y: -560), duration: 0.25 ), count: 1))
        storeBack.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 0, y: -560), duration: 0.25 ), count: 1))
        //removes tags if user owns the item
        if ownBlueGlove{
           alreadyBought(node1: glovePrice, node2: gloveTag)
        }
        if ownSword{
            alreadyBought(node1: swordPrice, node2: swordTag)
        }
        if ownBat{
            alreadyBought(node1: batPrice, node2: batTag)
        }
        if ownKnife{
            alreadyBought(node1: knifePrice, node2: knifeTag)
        }
        //checks to see which item the user assigned last, and moves the check over to that item
        if choseRedGlove{
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -279, y: -615.0), duration: 0.3 ), count: 1))
        }
        else if choseBlueGlove{
            alreadyBought(node1: swordPrice, node2: swordTag)
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -153, y: -615.0), duration: 0.3 ), count: 1))
        }
        else if choseSword{
            alreadyBought(node1: swordPrice, node2: swordTag)
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -22, y: -615.0), duration: 0.3 ), count: 1))
        }
        else if choseBat{
            alreadyBought(node1: batTag, node2: batPrice)
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 120, y: -615.0), duration: 0.3 ), count: 1))
        }
        else if choseKnife{
            alreadyBought(node1: knifeTag, node2: knifePrice)
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 275, y: -615.0), duration: 0.3 ), count: 1))
        }
        else{
            check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -279, y: -615.0), duration: 0.001 ), count: 1))
        }
        tabStatus = true
        
    }
    //animations for the pull up store closing
    func moveStoreDown(){
        check.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 0, y: -1000.0), duration: 0.001 ), count: 1))
        glovePrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -146.343, y: -864), duration: 0.25 ), count: 1))
        swordPrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -18.343, y: -864), duration: 0.25 ), count: 1))
        batPrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 125.343, y: -864), duration: 0.25 ), count: 1))
        knifePrice.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 271.343, y: -864), duration: 0.25 ), count: 1))
        gloveTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -187.343, y: -843), duration: 0.25 ), count: 1))
        swordTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -60.5, y: -843), duration: 0.25 ), count: 1))
        batTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 81.56, y: -843), duration: 0.25 ), count: 1))
        knifeTag.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 228.5, y: -843), duration: 0.25 ), count: 1))
        redGlove.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -289, y: -750), duration: 0.25 ), count:1))
        blueGlove.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -151, y: -750), duration: 0.25 ), count: 1))
        baseballbat.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 130, y: -760), duration: 0.25 ), count: 1))
        sword.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -1, y: -750), duration: 0.25 ), count: 1))
        knife.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 285, y: -750), duration: 0.25 ), count: 1))
        tab.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -56.108, y: -641.582), duration: 0.25 ), count: 1))
        tab2.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -56.108, y: -612.582), duration: 0.25 ), count: 1))
        tab3.run(SKAction.repeat(SKAction.move(to: CGPoint(x: -56.108, y: -582.582), duration: 0.25 ), count: 1))
        store.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 0, y: -816.334), duration: 0.25 ), count: 1))
        storeBack.run(SKAction.repeat(SKAction.move(to: CGPoint(x: 0, y: -823.00), duration: 0.25 ), count: 1))
        tabStatus = false
    }
    //combines the purchase functions to shrink both tag and price
    func alreadyBought(node1: SKNode, node2: SKNode){
        purchased(node: node1)
        purchased(node: node2)
    }
    func chaching(){
        do{
            //chaching sound from http://soundbible.com/tags-cha-ching.html
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "chaching", ofType: "mp3")!))
            audioPlayer2.prepareToPlay()
        }
        catch{
            print(error)
        }
        //plays song when menuscene starts
        audioPlayer2.play()
    }
    //not used
    override func update(_ currentTime: TimeInterval){
        points.text = "\(loggedPoints)"
        Spoints.text = "\(loggedPoints)"
        }
}

