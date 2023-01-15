//
//  MenuScene.swift
//  Space Invasion
//
//  Created by Punk József Ádám on 2018. 01. 15.
//  Copyright © 2018. Intuitive Computers. All rights reserved.
//


import SpriteKit

class MenuScene: SKScene {

	var screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
	var screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
    var startButton = SKSpriteNode()
    var optionsButton = SKSpriteNode()
    var creditsButton = SKSpriteNode()
    var goalsButton = SKSpriteNode()
	
    var startIndex = SKSpriteNode()
    var startIndexIsHidden = 0
    var startIndexTimer:Timer!
	
    var changeSpaceshipLeftButton = SKSpriteNode()
    var changeSpaceshipRightButton = SKSpriteNode()
	
    var animationSpaceship:SKSpriteNode!
    var animationAliens:SKSpriteNode!
	
    var spaceshipNum = 0
	
    var musicIsOn = 0
	
    var spaceshipSelected = SKTexture()
	
    let startButtonTex = SKTexture(imageNamed: "startButton")
    let optionsButtonTex = SKTexture(imageNamed: "optionsButton")
	let creditsButtonTex = SKTexture(imageNamed: "creditsButton")
	let goalsButtonTex = SKTexture(imageNamed: "goalsButton")
	
	let startIndexTex = SKTexture(imageNamed: "startIndex")
	
    let spaceInvasionLabelTex = SKTexture(imageNamed: "spaceInvasionLabel")
	
    let changeSpaceshipLeftButtonTex = SKTexture(imageNamed: "redLeftArrowButton")
    let changeSpaceshipRightButtonTex = SKTexture(imageNamed: "redRightArrowButton")
	
	var starfield:SKEmitterNode!

    var background:SKSpriteNode!
	
    var spaceInvasionLabel:SKSpriteNode!
	
    override func didMove(to view: SKView) {
		
//		self.size.width = UIScreen.main.bounds.width * UIScreen.main.scale
//		self.size.height = UIScreen.main.bounds.height * UIScreen.main.scale
		
		if screenWidth == 828 /* iPhone XR */ {
			
			self.size.width = 1080
			self.size.height = 2337
			screenWidth = 1080
			screenHeight = 2337
			
		}
		
		if screenWidth == 1125 /* iPhone X, XS */ {
			
			self.size.width = 1080
			self.size.height = 2339
			screenWidth = 1080
			screenHeight = 2339
			
		}
		
		if screenWidth == 1242 /* iPhone 6+,7+,8+ */ {
			
			self.size.width = 1080
			self.size.height = 1920
			screenWidth = 1080
			screenHeight = 1920
			
		}
	
		if screenWidth == 750 /* iPhone 6,7,8 */ {
			
			self.size.width = 1080
			self.size.height = 1920
			screenWidth = 1080
			screenHeight = 1920
			
		}

//		self.scaleMode = SKSceneScaleMode.aspectFit
//starfiled..............................
	
		starfield = SKEmitterNode(fileNamed: "Starfield")
		starfield.position = CGPoint(x: screenWidth / 2, y: screenHeight)
		starfield.advanceSimulationTime(10)
		starfield.zPosition = -1
		
		self.addChild(starfield)
		
		background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
		background.zPosition = -2
		
		self.addChild(background)
		
//animations.............................

//		animationSpaceship = SKSpriteNode(imageNamed: "menuArtworkSpaceship")
//		animationSpaceship.position = CGPoint(x: screenWidth / 2 - 600, y: screenHeight / 2)

//		self.addChild(animationSpaceship)

//		let animationDuration:TimeInterval = 1
//		var actionArray = [SKAction]()

//		actionArray.append(SKAction.move(to: CGPoint(x: screenWidth / 2, y: screenHeight / 2 + 100), duration: TimeInterval(animationDuration)))
//		animationSpaceship.run(SKAction.sequence(actionArray))
		

		
//		animationAliens = SKSpriteNode(imageNamed: "menuArtworkAliens")
//		animationAliens.position = CGPoint(x: screenWidth / 2 + 600, y: screenHeight / 2 + 200)
		
//		self.addChild(animationAliens)
		
//		actionArray.append(SKAction.move(to: CGPoint(x: screenWidth / 2, y: screenHeight / 2 + 100), duration: TimeInterval(animationDuration)))
		
//		animationAliens.run(SKAction.sequence(actionArray))
		







		
//space invasion labels..................
		
		spaceInvasionLabel = SKSpriteNode(texture: spaceInvasionLabelTex)
        spaceInvasionLabel.position = CGPoint(x: frame.midX, y: frame.midY + 480)
        spaceInvasionLabel.zPosition = 1
		
		self.addChild(spaceInvasionLabel)
		
//buttons

        startButton = SKSpriteNode(texture: startButtonTex)
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.zPosition = 1
		
        self.addChild(startButton)
		
        startIndex = SKSpriteNode(texture: startIndexTex)
        startIndex.position = CGPoint(x: frame.midX, y: frame.midY)
        startIndex.zPosition = 1
		
        self.addChild(startIndex)
		
		goalsButton = SKSpriteNode(texture: goalsButtonTex)
        goalsButton.position = CGPoint(x: frame.midX, y: frame.midY - 280)
        goalsButton.zPosition = 1
		
        self.addChild(goalsButton)
		
        optionsButton = SKSpriteNode(texture: optionsButtonTex)
        optionsButton.position = CGPoint(x: frame.midX, y: frame.midY - 420)
        optionsButton.zPosition = 1
		
        self.addChild(optionsButton)
		
        creditsButton = SKSpriteNode(texture: creditsButtonTex)
        creditsButton.position = CGPoint(x: frame.midX, y: frame.midY - 560)
        creditsButton.zPosition = 1
		
        self.addChild(creditsButton)
		
		
		
//timers
		startIndexTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(indexTimer), userInfo: nil, repeats: true)

	}
	
	
	
	
	
	
	@objc func indexTimer() {
	
		if startIndexIsHidden == 0 {
			startIndexIsHidden = 1
			startIndex.isHidden = true
		}
		else {
			startIndexIsHidden = 0
			startIndex.isHidden = false
		}
		
	}



    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
        if let touch = touches.first {
			
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

            if node == startButton {

					let transition:SKTransition = SKTransition.fade(withDuration: 0)
                    let scene:SKScene = SetupScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
				
            }
			
            if node == startIndex {

					let transition:SKTransition = SKTransition.fade(withDuration: 0)
                    let scene:SKScene = SetupScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
				
            }
			
            if node == optionsButton {

                    let transition:SKTransition = SKTransition.fade(withDuration: 0)
                    let scene:SKScene = OptionsScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)

            }
			
            if node == creditsButton {

                    let transition:SKTransition = SKTransition.fade(withDuration: 0)
                    let scene:SKScene = CreditsScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)

            }
			
            if node == goalsButton {
				
					let transition:SKTransition = SKTransition.fade(withDuration: 0)
                    let scene:SKScene = GoalsScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
				
			}
		}
    }
}
