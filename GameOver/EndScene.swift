//
//  EndScene.swift
//  BUMP
//
//  Created by Sebastian Revel on 11/25/17.
//  Copyright © 2017 Sebastian Revel. All rights reserved.
//
//defines/imports libraries to be used
import SpriteKit
import AVFoundation

class EndScene: SKScene {
    //background textures downloaded from http://makepixelart.com/peoplepods/files/images/318656.original.png
    //declares variables to be used
    var retryButton2 = SKSpriteNode()
    var player = SKSpriteNode()
    var retryButton = SKSpriteNode()
    var main = SKLabelNode()
    var mainButton = SKSpriteNode()
    var tryAgain = SKLabelNode()
    var highscore = SKLabelNode()
    var Shighscore = SKLabelNode()
    var endScore = SKLabelNode()
    var SendScore = SKLabelNode()
    var currentScore = UserDefaults().integer(forKey: "SCORE")
    var score = UserDefaults().integer(forKey: "HIGHSCORE")
    var choseBlueGlove = UserDefaults().bool(forKey: "choseBlueGlove")
    var choseSword = UserDefaults().bool(forKey: "choseSword")
    var choseBat = UserDefaults().bool(forKey: "choseBat")
    var choseKnife = UserDefaults().bool(forKey: "choseKnife")
    var audioPlayer = AVAudioPlayer()
    //defines variables appropriately
    override func didMove(to view: SKView){
        player = self.childNode(withName: "player") as! SKSpriteNode
        if choseBlueGlove{
            player.texture = SKTexture(imageNamed: "PLAYERblue")
            player.run(SKAction.repeatForever(SKAction.scale(to: 1.2, duration: 0.000001)))
        }
        if choseSword{
            player.texture = SKTexture(imageNamed: "Sword")
            player.run(SKAction.repeat(SKAction.rotate(byAngle: -.pi/4, duration:0.0000001), count: 1))
            player.run(SKAction.repeatForever(SKAction.scale(to: 1.95, duration: 0.000001)))
        }
        if choseBat{
            player.texture = SKTexture(imageNamed: "Baseballbat")
            player.run(SKAction.repeat(SKAction.rotate(byAngle: .pi/4, duration:0.0000001), count: 1))
            player.run(SKAction.repeatForever(SKAction.scale(to: 1.3, duration: 0.000001)))
        }
        if choseKnife{
            player.texture = SKTexture(imageNamed: "knife")
            player.run(SKAction.repeat(SKAction.rotate(byAngle: .pi/3.75, duration:0.0000001), count: 1))
            player.run(SKAction.repeatForever(SKAction.scale(to: 1.8, duration: 0.000001)))
        }
        retryButton = self.childNode(withName: "retryButton") as! SKSpriteNode
        mainButton = self.childNode(withName: "menuButton") as! SKSpriteNode
        tryAgain = self.childNode(withName: "tryAgain") as! SKLabelNode
        main = self.childNode(withName: "menu") as! SKLabelNode
        highscore = self.childNode(withName: "highscore") as! SKLabelNode
        Shighscore = self.childNode(withName: "Shighscore") as! SKLabelNode
        endScore = self.childNode(withName: "endScore") as! SKLabelNode
        SendScore = self.childNode(withName: "SendScore") as! SKLabelNode
        
        endScore.text = "\(currentScore)"
        highscore.text = "\(score)"
        SendScore.text = "\(currentScore)"
        Shighscore.text = "\(score)"
        animateNodes([player])
        //runs necessary prerequisites to playing a song/sound
        do{
            //theme song from Sonic the Hedgehog Game Over Sound SEGA at https://www.youtube.com/watch?v=l_Uo0VJihCU
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "endsong", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        //plays song when game starts
        audioPlayer.play()
    }
    //checks to see if user touches retry button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        //pushes visual button inwards
        if retryButton.contains(touch.location(in:self)){
            let push = SKAction.scale(by: 0.90, duration: 0.001)
            retryButton.run(SKAction.repeat(push, count: 1))
            tryAgain.run(SKAction.repeat(push, count: 1))
            bump(xPoint: 0, yPoint: -80)
        }
        if mainButton.contains(touch.location(in:self)){
            let push = SKAction.scale(by: 0.90, duration: 0.001)
            mainButton.run(SKAction.repeat(push, count: 1))
            main.run(SKAction.repeat(push, count: 1))
            bump(xPoint: 0, yPoint: -480)
            player.run(SKAction.repeat(SKAction.rotate(byAngle: .pi, duration:0.1), count: 1))
        }
    }
    //function from (https://www.swiftbysundell.com/posts/using-spritekit-to-create-animations-in-swift)
    //creates the "breathing-like" animation for the characters to give the game life
    func animateNodes(_ nodes: [SKNode]){
        for (index, node) in nodes.enumerated(){
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .repeatForever(.sequence([
                    .scale(to: 1.1, duration: 0.3),
                    .scale(to: 1.4, duration: 0.3),
                    ]))
                ]))
        }
    }
    func bump(xPoint: CGFloat, yPoint: CGFloat){
        let move = SKAction.move(to: CGPoint(x: xPoint, y:  yPoint), duration: 0.1)
        let moveCenter = SKAction.move(to: CGPoint(x: 0, y:  -260), duration: 0.3)
        player.run(SKAction.repeat(SKAction.sequence([move, moveCenter]), count: 1))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //if user releases the push, transition back to game scene
        if retryButton.contains(touch.location(in:self)){
            let pull = SKAction.scale(by: 1.1, duration: 0.1)
            retryButton.run(SKAction.repeat(pull, count: 1))
            tryAgain.run(SKAction.repeat(pull, count: 1))
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150), execute: {
                let transition = SKTransition.fade(withDuration: 0.5)
                let gameScene = GameScene(fileNamed:"GameScene")
                gameScene?.scaleMode = .aspectFit
                self.view?.presentScene(gameScene!, transition: transition)
            })
        }
        if mainButton.contains(touch.location(in:self)){
            let pull = SKAction.scale(by: 1.1, duration: 0.1)
            mainButton.run(SKAction.repeat(pull, count: 1))
            main.run(SKAction.repeat(pull, count: 1))
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150), execute: {
                let transition = SKTransition.fade(withDuration: 0.5)
                let menuScene = MenuScene(fileNamed:"MenuScene")
                menuScene?.scaleMode = .aspectFit
                self.view?.presentScene(menuScene!, transition: transition)
            })
        }
    }
    //not used
    override func update(_ currentTime: TimeInterval){
    }
}
