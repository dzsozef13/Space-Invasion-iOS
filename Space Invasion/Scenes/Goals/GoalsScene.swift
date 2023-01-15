//
//  AchievementsScene.swift
//  Space Invasion
//
//  Created by Punk József on 2018. 06. 28.
//  Copyright © 2018. Intuitive Computers. All rights reserved.
//

import SpriteKit

class GoalsScene: SKScene {

	var screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
	var screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
	
	var starfield:SKEmitterNode!
	var background:SKSpriteNode!
	
    var homeButton = SKSpriteNode()
	
	let homeButtonTex = SKTexture(imageNamed: "back_button")
	
	var ach1 = SKSpriteNode()
	var ach2 = SKSpriteNode()
	var ach3 = SKSpriteNode()
	var ach4 = SKSpriteNode()
	var ach5 = SKSpriteNode()
	var ach6 = SKSpriteNode()
	var ach7 = SKSpriteNode()
	var ach8 = SKSpriteNode()
	var ach9 = SKSpriteNode()
	
	var ach1Dis = SKSpriteNode()
	var ach2Dis = SKSpriteNode()
	var ach3Dis = SKSpriteNode()
	var ach4Dis = SKSpriteNode()
	var ach5Dis = SKSpriteNode()
	var ach6Dis = SKSpriteNode()
	var ach7Dis = SKSpriteNode()
	var ach8Dis = SKSpriteNode()
	var ach9Dis = SKSpriteNode()
	
	let ach1Tex = SKTexture(imageNamed: "infoButton")
	let ach2Tex = SKTexture(imageNamed: "infoButton")
	let ach3Tex = SKTexture(imageNamed: "infoButton")
	let ach4Tex = SKTexture(imageNamed: "infoButton")
	let ach5Tex = SKTexture(imageNamed: "infoButton")
	let ach6Tex = SKTexture(imageNamed: "infoButton")
	let ach7Tex = SKTexture(imageNamed: "infoButton")
	let ach8Tex = SKTexture(imageNamed: "infoButton")
	let ach9Tex = SKTexture(imageNamed: "infoButton")
	
	let ach1DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach2DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach3DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach4DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach5DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach6DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach7DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach8DisTex = SKTexture(imageNamed: "spaceInvasionLabel")
	let ach9DisTex = SKTexture(imageNamed: "spaceInvasionLabel")

	var hideAchDisIsActive = 0
	

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
		starfield.zPosition = -2

		self.addChild(starfield)
	
		background = SKSpriteNode(imageNamed: "background")
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		background.zPosition = -3
	
		self.addChild(background)
	
//buttons...............................

		homeButton = SKSpriteNode(texture: homeButtonTex)
		homeButton.position = CGPoint(x: frame.midX - 340, y: frame.midY - 710)

		self.addChild(homeButton)
	
//achievements..........................

		ach1 = SKSpriteNode(texture: ach1Tex)
		ach1.position = CGPoint(x: frame.midX - 300, y: frame.midY + 300)

		self.addChild(ach1)
	
		ach2 = SKSpriteNode(texture: ach2Tex)
		ach2.position = CGPoint(x: frame.midX - 300, y: frame.midY)

		self.addChild(ach2)
	
		ach3 = SKSpriteNode(texture: ach3Tex)
		ach3.position = CGPoint(x: frame.midX - 300, y: frame.midY - 300)

		self.addChild(ach3)
	
	
	
		ach4 = SKSpriteNode(texture: ach4Tex)
		ach4.position = CGPoint(x: frame.midX, y: frame.midY + 300)

		self.addChild(ach4)
	
		ach5 = SKSpriteNode(texture: ach5Tex)
		ach5.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach5)
	
		ach6 = SKSpriteNode(texture: ach6Tex)
		ach6.position = CGPoint(x: frame.midX, y: frame.midY - 300)

		self.addChild(ach6)
	
	
	
		ach7 = SKSpriteNode(texture: ach7Tex)
		ach7.position = CGPoint(x: frame.midX + 300, y: frame.midY + 300)

		self.addChild(ach7)
	
		ach8 = SKSpriteNode(texture: ach8Tex)
		ach8.position = CGPoint(x: frame.midX + 300, y: frame.midY)

		self.addChild(ach8)
	
		ach9 = SKSpriteNode(texture: ach9Tex)
		ach9.position = CGPoint(x: frame.midX + 300, y: frame.midY - 300)

		self.addChild(ach9)
	
	
	
		ach1Dis = SKSpriteNode(texture: ach1DisTex)
		ach1Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach1Dis)
		ach1Dis.isHidden = true
	
		ach2Dis = SKSpriteNode(texture: ach2DisTex)
		ach2Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach2Dis)
		ach2Dis.isHidden = true
	
		ach3Dis = SKSpriteNode(texture: ach3DisTex)
		ach3Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach3Dis)
		ach3Dis.isHidden = true
	
		ach4Dis = SKSpriteNode(texture: ach4DisTex)
		ach4Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach4Dis)
		ach4Dis.isHidden = true
	
		ach5Dis = SKSpriteNode(texture: ach5DisTex)
		ach5Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach5Dis)
		ach5Dis.isHidden = true
	
		ach6Dis = SKSpriteNode(texture: ach6DisTex)
		ach6Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach6Dis)
		ach6Dis.isHidden = true
	
		ach7Dis = SKSpriteNode(texture: ach7DisTex)
		ach7Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach7Dis)
		ach7Dis.isHidden = true
	
		ach8Dis = SKSpriteNode(texture: ach8DisTex)
		ach8Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach8Dis)
		ach8Dis.isHidden = true
	
		ach9Dis = SKSpriteNode(texture: ach9DisTex)
		ach9Dis.position = CGPoint(x: frame.midX, y: frame.midY)

		self.addChild(ach9Dis)
		ach9Dis.isHidden = true
	
	
	
	
	
	
	
	
	
	
	
		
	
	
	}
	
	func hideAchs() {
	
		ach1.isHidden = true
		ach2.isHidden = true
		ach3.isHidden = true
		ach4.isHidden = true
		ach5.isHidden = true
		ach6.isHidden = true
		ach7.isHidden = true
		ach8.isHidden = true
		ach9.isHidden = true
		
	}
	
	func showAchs() {
	
		ach1.isHidden = false
		ach2.isHidden = false
		ach3.isHidden = false
		ach4.isHidden = false
		ach5.isHidden = false
		ach6.isHidden = false
		ach7.isHidden = false
		ach8.isHidden = false
		ach9.isHidden = false
		
	}
	
	func hideAchDis() {
	
		ach1Dis.isHidden = true
		ach2Dis.isHidden = true
		ach3Dis.isHidden = true
		ach4Dis.isHidden = true
		ach5Dis.isHidden = true
		ach6Dis.isHidden = true
		ach7Dis.isHidden = true
		ach8Dis.isHidden = true
		ach9Dis.isHidden = true
	
	}
	
	
//touch detection.....................

	
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
	
		if hideAchDisIsActive == 1 {
		
			hideAchDis()
			showAchs()
			
		}
		
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
			
			if node == homeButton {
			
				let transition:SKTransition = SKTransition.fade(withDuration: 0)
				let scene:SKScene = MenuScene(size: self.size)
				self.view?.presentScene(scene, transition: transition)
			
			}
			
			if node == ach1 {
			
				ach1Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach2 {
			
				ach2Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach3 {
			
				ach3Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach4 {
			
				ach4Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach5 {
			
				ach5Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach6 {
			
				ach6Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach7 {
			
				ach7Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach8 {
			
				ach8Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			if node == ach9 {
			
				ach9Dis.isHidden = false
				hideAchDisIsActive = 1
				hideAchs()
			
			}
			
			
			
			
			
			
			
		}
	}
}
