//
//  OptionsScene.swift
//  Space Invasion
//
//  Created by Punk József on 2018. 03. 28.
//  Copyright © 2018. Intuitive Computers. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {

	var screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
	var screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
	
	var gameMode = UserDefaults().integer(forKey: "GameMode")
	
	var homeButton = SKSpriteNode()
	var gameModeButton = SKSpriteNode()
	
	let homeButtonTex = SKTexture(imageNamed: "back_button")
	//let gameModeButtonTex = SKTexture(imageNamed: "button01")
	
	var starfield:SKEmitterNode!
	
    var background:SKSpriteNode!
    
    var bestScoreLabel:SKLabelNode!
	var xpLabel:SKLabelNode!
	
	override func didMove(to view: SKView) {
	
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
	
//buttons

		homeButton = SKSpriteNode(texture: homeButtonTex)
		homeButton.position = CGPoint(x: frame.midX - 340, y: frame.midY - 710)

		self.addChild(homeButton)
	
		/*gameModeButton = SKSpriteNode(texture: gameModeButtonTex)
		gameModeButton.position = CGPoint(x: 540, y: 640)

		self.addChild(gameModeButton)*/
		
//score
		
		bestScoreLabel = SKLabelNode(text: String(UserDefaults().integer(forKey: "LastScore")))
		bestScoreLabel.position = CGPoint(x: screenWidth / 2, y: screenHeight - 400)
		bestScoreLabel.zPosition = 3
		bestScoreLabel.fontSize = 75
		bestScoreLabel.fontColor = UIColor.white
		bestScoreLabel.fontName = "boldp"
		
		self.addChild(bestScoreLabel)
		
		xpLabel = SKLabelNode(text: String(UserDefaults().integer(forKey: "ExperiencePoints")))
		xpLabel.position = CGPoint(x: screenWidth / 2, y: screenHeight - 600)
		xpLabel.zPosition = 3
		xpLabel.fontSize = 75
		xpLabel.fontColor = UIColor.white
		xpLabel.fontName = "boldp"
		
		self.addChild(xpLabel)

	}



    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
        if let touch = touches.first {
			
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)

            if node == homeButton {

                    let transition:SKTransition = SKTransition.fade(withDuration: 0)
                    let scene:SKScene = SetupScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)

            }
		}
    }
}

