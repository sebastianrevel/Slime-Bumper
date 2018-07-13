//
//  GameScene.swift
//  BUMPer
//
//  Created by Sebastian Revel on 11/19/17.
//  Copyright © 2017 Sebastian Revel. All rights reserved.
//
//defines/imports libraries to be used
import SpriteKit
import GameplayKit
import Foundation
import AVFoundation

class GameScene: SKScene{
    //background textures downloaded from http://makepixelart.com/peoplepods/files/images/318656.original.png
    // declares variables to be used
    var viewController: GameViewController!
    var intro1 = SKLabelNode()
    var Sintro1 = SKLabelNode()
    var intro2 = SKLabelNode()
    var Sintro2 = SKLabelNode()
    var player = SKSpriteNode()
    var bump1 = SKSpriteNode()
    var bump2 = SKSpriteNode()
    var bump3 = SKSpriteNode()
    var bump4 = SKSpriteNode()
    var count = SKLabelNode()
    var Scount = SKLabelNode()
    var cover = SKSpriteNode()
    var time = SKSpriteNode()
    var score = 0
    var comp1 = false
    var comp2 = false
    var comp3 = false
    var comp4 = false
    var audioPlayer = AVAudioPlayer()
    var moveRight = true
    var moveLeft = false
    var highScore = UserDefaults().integer(forKey: "HIGHSCORE")
    var currentScore = UserDefaults().integer(forKey: "SCORE")
    var points = UserDefaults().integer(forKey: "POINTS")
    var choseKnife = UserDefaults().bool(forKey: "choseKnife")
    var choseRedGlove = UserDefaults().bool(forKey: "choseRedGlove")
    var choseBlueGlove = UserDefaults().bool(forKey: "choseBlueGlove")
    var choseSword = UserDefaults().bool(forKey: "choseSword")
    var choseBat = UserDefaults().bool(forKey: "choseBat")
    //defines the functions to be used when movement is made.
    override func didMove(to view: SKView){
        startGame()
        //boxing glove designed by BauerGraphics from http://piq.codeus.net/picture/23631/boxing_glove
        player = self.childNode(withName: "player") as! SKSpriteNode
        //checks to see which item the user selected and assigns/resizes the texture to fix the game
        if choseBlueGlove{
            player.texture = SKTexture(imageNamed: "PLAYERblue")
        }
        if choseSword{
            player.texture = SKTexture(imageNamed: "Sword")
            player.run(SKAction.repeat(SKAction.rotate(byAngle: -.pi/4, duration:0.0000001), count: 1))
            player.run(SKAction.repeatForever(SKAction.scale(to: 1.65, duration: 0.000001)))
        }
        if choseBat{
            player.texture = SKTexture(imageNamed: "Baseballbat")
            player.run(SKAction.repeat(SKAction.rotate(byAngle: .pi/4, duration:0.0000001), count: 1))
           
        }
        if choseKnife{
            player.texture = SKTexture(imageNamed: "knife")
            player.run(SKAction.repeat(SKAction.rotate(byAngle: .pi/3.75, duration:0.0000001), count: 1))
            player.run(SKAction.repeatForever(SKAction.scale(to: 1.4, duration: 0.000001)))
        }
        //slime character designed by pixelsandthings from http://pixelsandthings.tumblr.com/post/21111849500
        bump1 = self.childNode(withName: "bump1") as! SKSpriteNode
        //slime character designed by pixelsandthings from http://pixelsandthings.tumblr.com/post/21111849500
        bump2 = self.childNode(withName: "bump2") as! SKSpriteNode
        //slime character designed by pixelsandthings from http://pixelsandthings.tumblr.com/post/21111849500
        bump3 = self.childNode(withName: "bump3") as! SKSpriteNode
        //slime character designed by pixelsandthings from http://pixelsandthings.tumblr.com/post/21111849500
        bump4 = self.childNode(withName: "bump4") as! SKSpriteNode
        intro1 = self.childNode(withName:"intro1") as! SKLabelNode
        Sintro1 = self.childNode(withName:"Sintro1") as! SKLabelNode
        intro2 = self.childNode(withName:"intro2") as! SKLabelNode
        Sintro2 = self.childNode(withName:"Sintro2") as! SKLabelNode
        time = self.childNode(withName: "timeblock") as! SKSpriteNode
        count = self.childNode(withName: "count") as! SKLabelNode
        Scount = self.childNode(withName: "Scount") as! SKLabelNode
        //animates the four characters so that they oscillate back and fourth in size; creates a lively animation
        animateNodes([bump1])
        animateNodes([bump2])
        animateNodes([bump3])
        animateNodes([bump4])
        blinker([intro1])
        blinker([Sintro1])
        blinker([intro2])
        blinker([Sintro2])
        do{
            //theme song from Sonic the Hedgehog Spinball SEGA at https://www.youtube.com/watch?v=bkWUJfIotfU
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "theme", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        audioPlayer.play()
    }
    //defines the score as soon as the user moves
    //starts time depletion
    func startGame(){
        count.text = "\(score)"
        Scount.text = "\(score)"
        deplete([time])
    }
    //defines the behavior of touches/taps
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        intro1.removeFromParent()
        Sintro1.removeFromParent()
        intro2.removeFromParent()
        Sintro2.removeFromParent()
        //if the top node is touched, it will check if it is a kitty or a slime
        if bump1.contains(touch.location(in: self)){
            bump(xPoint: 0, yPoint: 200)
            //if it is a slime it will run various animations and functions, commented later in the code
            if comp1 == false{
                death(node: bump1)
                deplete([time])
                comp1 = boolMaker()
                generator(node: bump1, comp: comp1)
                score += 1
                count.text = "\(score)"
                Scount.text = "\(score)"
            }
            //if it is a kitty, game will end
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(75), execute: {
                self.gameOver()
                })
            }
            //if it is a kitty it will wait 1 second and turn into a slime.
            if comp1{
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.comp1 = false
                    self.death(node: self.bump1)
                    self.generator(node: self.bump1, comp: self.comp1)
                })
            }
        }
        //if the top node is touched, it will check if it is a kitty or a slime
        else if bump2.contains(touch.location(in: self)){
            bump(xPoint: 200, yPoint: 0)
            rotate(rad: .pi/2, leftRight: moveRight)
            //if it is a slime it will run various animations and functions, commented later in the code
            if comp2 == false{
                death(node: bump2)
                deplete([time])
                comp2 = boolMaker()
                generator(node: bump2, comp: comp2)
                score += 1
                count.text = "\(score)"
                Scount.text = "\(score)"
                
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                self.gameOver()
                })
            }
            //if it is a kitty it will wait 1 second and turn into a slime.
            if comp2{
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.comp2 = false
                    self.death(node: self.bump2)
                    self.generator(node: self.bump2, comp: self.comp2)
                })
            }
        }
        //if the top node is touched, it will check if it is a kitty or a slime
        else if bump3.contains(touch.location(in: self)){
            bump(xPoint: 0, yPoint: -200)
            rotate(rad: .pi, leftRight: moveRight)
            //if it is a slime it will run various animations and functions, commented later in the code
            if comp3 == false{
                death(node: bump3)
                deplete([time])
                comp3 = boolMaker()
                generator(node: bump3, comp: comp3)
                score += 1
                count.text = "\(score)"
                Scount.text = "\(score)"
                
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                self.gameOver()
                })
            }
            //if it is a kitty it will wait 1 second and turn into a slime.
            if comp3{
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.comp3 = false
                    self.death(node: self.bump3)
                    self.generator(node: self.bump3, comp: self.comp3)
                })
            }
        }
        //if the top node is touched, it will check if it is a kitty or a slime
        else if bump4.contains(touch.location(in: self)){
            bump(xPoint: -200, yPoint: 0)
            rotate(rad: .pi/2, leftRight: moveLeft)
            //if it is a slime it will run various animations and functions, commented later in the code
            if comp4 == false{
                death(node: bump4)
                deplete([time])
                comp4 = boolMaker()
                generator(node: bump4, comp: comp4)
                score += 1
                count.text = "\(score)"
                Scount.text = "\(score)"
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                self.gameOver()
                })
            }
            //if it is a kitty it will wait 1 second and turn into a slime.
            if comp4{
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    self.comp4 = false
                    self.death(node: self.bump4)
                    self.generator(node: self.bump4, comp: self.comp4)
                })
            }
        }
    }
    //function from (https://www.swiftbysundell.com/posts/using-spritekit-to-create-animations-in-swift)
    //creates the "breathing-like" animation for the characters to give the game life
    func animateNodes(_ nodes: [SKNode]){
        for (index, node) in nodes.enumerated(){
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    .scale(to: 0.25, duration: 0.3),
                    .scale(to: 0.20, duration: 0.3),
                    ]))
                ]))
        }
    }
    //is ran when game ends and transitions scene to game over scene as well as recorded the current score of the game
    func gameOver(){
        currentScore = score
        UserDefaults.standard.set(score, forKey: "SCORE")
        points += (score/25)
        UserDefaults.standard.set(points, forKey: "POINTS")
        let transition = SKTransition.fade(withDuration: 0.5)
        let endScene = EndScene(fileNamed:"EndScene")
        endScene?.scaleMode = .aspectFit
        self.view?.presentScene(endScene!, transition: transition)
    }
    //depletes the timeblock sprite at the top of the screen to give a visual representation of depleting time to the user
    func deplete(_ nodes: [SKNode]){
        let ratio = time.frame.width / 750
        if time.frame.width <= 750{
            for (index, node) in nodes.enumerated(){
                node.run(.sequence([
                    .wait(forDuration: TimeInterval(index) * 0.2),
                    .repeat(.sequence([
                        .resize(toWidth: ((ratio)*100) + 7.5, duration: 0.00001),
                        .resize(toWidth: 0, duration: (TimeInterval((ratio)*5)))
                        ]), count: 1)
                    ]))
            }
        }
    }
    //runs the dash animation when a user touches a node
    func bump(xPoint: CGFloat, yPoint: CGFloat){
        let move = SKAction.move(to: CGPoint(x: xPoint, y:  yPoint), duration: 0.1)
        let moveCenter = SKAction.move(to: CGPoint(x: 0, y:  0), duration: 0.3)
        player.run(SKAction.repeat(SKAction.sequence([move, moveCenter]), count: 1))
    }
    //creates a true/false definition for the spawn system
    func boolMaker() -> Bool {
        return arc4random_uniform(2) == 0
    }
    //runs the shrinking death animation
    func death(node: SKNode){
        let shrink = SKAction.scale(to: 0.0, duration: 0.25)
        node.run(SKAction.repeatForever(shrink))
    }
    //generates a slime or kitty depending on the result of the boolmaker
    func generator(node: SKSpriteNode, comp: Bool){
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400), execute:{
            if comp{
                node.texture = SKTexture(imageNamed: "KITTY")
                node.run(SKAction.repeatForever(SKAction.scale(to: 0.35, duration: 0.25)))
                self.animateNodes([node])
            }
            else{
                node.texture = SKTexture(imageNamed: "SLIMEY.jpg")
                node.run(SKAction.repeatForever(SKAction.scale(to: 0.35, duration: 0.25)))
                self.animateNodes([node])
            }
        })
    }
    //rotates the boxing glove to where the touch is
    func rotate(rad: CGFloat, leftRight: Bool){
        if leftRight{
            let action = SKAction.rotate(byAngle: -(rad), duration:0.1)
            player.run(SKAction.repeat(action, count: 1))
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                let undoAction = SKAction.rotate(byAngle: rad, duration:0.1)
                self.player.run(SKAction.repeat(undoAction, count: 1))
        })
        }
        else{
        let action = SKAction.rotate(byAngle: rad, duration:0.1)
        player.run(SKAction.repeat(action, count: 1))
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
            let undoAction = SKAction.rotate(byAngle: -rad, duration:0.1)
            self.player.run(SKAction.repeat(undoAction, count: 1))
            })
        }
    }
    //saves the highscore
    func saveScore(){
        UserDefaults.standard.set(score, forKey: "HIGHSCORE")
    }
    //runs instructional blinker
    func blinker(_ nodes: [SKNode]){
        for (index, node) in nodes.enumerated(){
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    .fadeIn(withDuration: 0.3),
                    .fadeOut(withDuration: 0.3)
                    ]))
                ]))
        }
    }
    //constantly checks everyframe
    override func update(_ currentTime: TimeInterval){
        //if the time block becomes zero, game ends
        if time.frame.width == 0{
            gameOver()
        }
        //if the user's current score is higher than the logged highscore, it will update the highscore
        if score > highScore{
            highScore = score
            saveScore()
        }
    }
}
