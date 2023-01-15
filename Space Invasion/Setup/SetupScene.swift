//
//  SetupScene.swift
//  Space Invasion
//
//  Created by Punk József on 2018. 03. 22.
//  Copyright © 2018. Intuitive Computers. All rights reserved.
//

import SpriteKit

class SetupScene: SKScene {

	var screenWidth = UIScreen.main.bounds.width * UIScreen.main.scale
	var screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
	
	var setupIndex = SKSpriteNode()
    var setupIndexIsHidden = 0
    var setupIndexTimer:Timer!
	
	var spaceshipNum = 1
	
	var balance = UserDefaults().integer(forKey: "ExperiencePoints")
	
	var selectedSpaceship = UserDefaults().integer(forKey: "SelectedSpaceship")
	
	var spaceship1IsBought = 1
	var spaceship2IsBought = UserDefaults().integer(forKey: "Spaceship2IsBought")
	var spaceship3IsBought = UserDefaults().integer(forKey: "Spaceship3IsBought")
	var spaceship4IsBought = UserDefaults().integer(forKey: "Spaceship4IsBought")
	var spaceship5IsBought = UserDefaults().integer(forKey: "Spaceship5IsBought")
	var spaceship6IsBought = UserDefaults().integer(forKey: "Spaceship6IsBought")
	var spaceship7IsBought = UserDefaults().integer(forKey: "Spaceship7IsBought")
	var spaceship8IsBought = UserDefaults().integer(forKey: "Spaceship8IsBought")
	
	var spaceship2Price = 10
	var spaceship3Price = 10
	var spaceship4Price = 10
	var spaceship5Price = 10
	var spaceship6Price = 10
	var spaceship7Price = 10
	var spaceship8Price = 10

	var spaceshipShowed = SKSpriteNode()
	var spaceshipName = SKLabelNode()
	
	var playButton = SKSpriteNode()
	var homeButton = SKSpriteNode()
	var changeSpaceshipLeftButton = SKSpriteNode()
    var changeSpaceshipRightButton = SKSpriteNode()
    
    var balanceLabel = SKSpriteNode()
    
    var xpLabel:SKLabelNode!
	
    let playButtonTex = SKTexture(imageNamed: "go_button")
    let homeButtonTex = SKTexture(imageNamed: "back_button")
    let setupIndexTex = SKTexture(imageNamed: "setup_index")
    let changeSpaceshipLeftButtonTex = SKTexture(imageNamed: "left_button")
    let changeSpaceshipRightButtonTex = SKTexture(imageNamed: "right_button")
    
    let balanceLabelTex = SKTexture(imageNamed: "balance_label")
	
	var starfield:SKEmitterNode!

    var background:SKSpriteNode!

	override func didMove(to view: SKView) {
	
		checkSelectedSpaceship()
		
		setupIndexTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(indexTimer), userInfo: nil, repeats: true)

	
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
	
//buttons and controls...................

		setupIndex = SKSpriteNode(texture: setupIndexTex)
        setupIndex.position = CGPoint(x: frame.midX + 275, y: frame.midY - 710)
        setupIndex.zPosition = 1
		
        self.addChild(setupIndex)
		
		playButton = SKSpriteNode(texture: playButtonTex)
		playButton.position = CGPoint(x: frame.midX + 275, y: frame.midY - 710)
		
		self.addChild(playButton)
		
		homeButton = SKSpriteNode(texture: homeButtonTex)
		homeButton.position = CGPoint(x: frame.midX - 340, y: frame.midY - 710)
		
		self.addChild(homeButton)
		
		changeSpaceshipLeftButton = SKSpriteNode(texture: changeSpaceshipLeftButtonTex)
		changeSpaceshipLeftButton.position = CGPoint(x: frame.midX - 300, y: frame.midY + 200)
		changeSpaceshipLeftButton.zPosition = 2
		
		self.addChild(changeSpaceshipLeftButton)
		
		changeSpaceshipRightButton = SKSpriteNode(texture: changeSpaceshipRightButtonTex)
		changeSpaceshipRightButton.position = CGPoint(x: frame.midX + 300, y: frame.midY + 200)
		changeSpaceshipRightButton.zPosition = 2

		self.addChild(changeSpaceshipRightButton)
		
		balanceLabel = SKSpriteNode(texture: balanceLabelTex)
		balanceLabel.position = CGPoint(x: frame.midX - 308, y: frame.midY + 730)
		balanceLabel.zPosition = 2

		self.addChild(balanceLabel)
		
		xpLabel = SKLabelNode(text: String(UserDefaults().integer(forKey: "ExperiencePoints")))
		xpLabel.position = CGPoint(x: frame.midX, y: frame.midY + 730)
		xpLabel.zPosition = 3
		xpLabel.fontSize = 75
		xpLabel.fontColor = UIColor.white
		xpLabel.fontName = "boldp"
		
		self.addChild(xpLabel)
		
		
//name...................................

		/*spaceshipName = SKLabelNode(text: "SPACESHIP")
		spaceshipName.position = CGPoint(x: frame.midX, y: frame.midY + 700)
		spaceshipName.zPosition = 3
		spaceshipName.fontSize = 75
		spaceshipName.fontColor = UIColor.white
		spaceshipName.fontName = "boldp"
	
		self.addChild(spaceshipName)*/
		
	
	
	}
	
	@objc func indexTimer() {
	
		if setupIndexIsHidden == 0 {
			setupIndexIsHidden = 1
			setupIndex.isHidden = true
		}
		else {
			setupIndexIsHidden = 0
			setupIndex.isHidden = false
		}
	}
	
	func updateBalance() {
	
		xpLabel.removeFromParent()
		
		xpLabel = SKLabelNode(text: String(UserDefaults().integer(forKey: "ExperiencePoints")))
		xpLabel.position = CGPoint(x: frame.midX, y: frame.midY + 730)
		xpLabel.zPosition = 3
		xpLabel.fontSize = 75
		xpLabel.fontColor = UIColor.white
		xpLabel.fontName = "boldp"
		
		self.addChild(xpLabel)
	}
	
	
	func checkSelectedSpaceship() {
	
		playButton.removeFromParent()
	
		if spaceshipNum == 1 {
		
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			playButton = SKSpriteNode(imageNamed: "play_button")
			spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		
		}
		
		if spaceshipNum == 2 {
			
			spaceshipShowed.removeFromParent()
			if spaceship2IsBought == 1 {
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
				
			}
			if spaceship2IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "eagle_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		if spaceshipNum == 3 {
				
			spaceshipShowed.removeFromParent()
			if spaceship3IsBought == 1	{
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
			if spaceship3IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "turtle_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		if spaceshipNum == 4 {
				
			spaceshipShowed.removeFromParent()
			if spaceship4IsBought == 1	{
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
			if spaceship4IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "elephant_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		if spaceshipNum == 5 {
				
			spaceshipShowed.removeFromParent()
			if spaceship5IsBought == 1	{
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
			if spaceship5IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "falcon_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		if spaceshipNum == 6 {
			
			spaceshipShowed.removeFromParent()
			if spaceship6IsBought == 1	{
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
			if spaceship6IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "squid_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		if spaceshipNum == 7 {
			
			spaceshipShowed.removeFromParent()
			if spaceship7IsBought == 1	{
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
			if spaceship7IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
				spaceshipShowed = SKSpriteNode(imageNamed: "theo_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		if spaceshipNum == 8 {
				
			spaceshipShowed.removeFromParent()
			if spaceship8IsBought == 1	{
				playButton = SKSpriteNode(imageNamed: "play_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
			if spaceship6IsBought == 0 {
				playButton = SKSpriteNode(imageNamed: "buy_button")
				spaceshipShowed = SKSpriteNode(imageNamed: "spiderx_locked_setup")
			}
			UserDefaults().set(spaceshipNum, forKey: "SelectedSpaceship")
			spaceshipShowed.position = CGPoint(x: frame.midX, y: frame.midY - 90)
			addChild(spaceshipShowed)
		}
		
		playButton.position = CGPoint(x: frame.midX + 275, y: frame.midY - 710)
		self.addChild(playButton)
	}
	
	
	
	
	
	func buySpaceship() {
		
		if spaceshipNum == 2 {
			if balance >= spaceship2Price {
				balance = balance - spaceship2Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship2IsBought")
				spaceshipShowed.removeFromParent()
				spaceshipShowed = SKSpriteNode(imageNamed: "starfightersi_setup")
			}
		}
		
		if spaceshipNum == 3 {
			if balance >= spaceship3Price {
				balance = balance - spaceship3Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship3IsBought")
			}
		}
		
		if spaceshipNum == 4 {
			if balance >= spaceship4Price {
				balance = balance - spaceship5Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship4IsBought")
			}
		}
		
		if spaceshipNum == 5 {
			if balance >= spaceship5Price {
				balance = balance - spaceship5Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship5IsBought")
			}
		}
		
		if spaceshipNum == 6 {
			if balance >= spaceship6Price {
				balance = balance - spaceship6Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship6IsBought")
			}
		}
		
		if spaceshipNum == 7 {
			if balance >= spaceship7Price {
				balance = balance - spaceship7Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship7IsBought")
			}
		}
		
		if spaceshipNum == 8 {
			if balance >= spaceship8Price {
				balance = balance - spaceship8Price
				UserDefaults().set(balance, forKey: "ExperiencePoints")
				UserDefaults().set(1, forKey: "Spaceship8IsBought")
			}
		}
	}
	
	
	func startGame() {
		let transition:SKTransition = SKTransition.fade(withDuration: 0)
		let scene:SKScene = GameScene(size: self.size)
		self.view?.presentScene(scene, transition: transition)
	}
	
	
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
			
			if node == playButton {
							
				if spaceshipNum == 1 {
					startGame()
				}
				
				if spaceshipNum == 2 {
					if spaceship2IsBought == 1 {
							startGame()
					}
					if spaceship2IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 3 {
					if spaceship3IsBought == 1 {
							startGame()
					}
					if spaceship3IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 4 {
					if spaceship4IsBought == 1 {
							startGame()
					}
					if spaceship4IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 5 {
					if spaceship5IsBought == 1 {
							startGame()
					}
					if spaceship5IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 6 {
					if spaceship2IsBought == 1 {
							startGame()
					}
					if spaceship6IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 7 {
					if spaceship7IsBought == 1 {
							startGame()
					}
					if spaceship7IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 8 {
					if spaceship8IsBought == 1 {
							startGame()
					}
					if spaceship8IsBought == 0 {
							buySpaceship()
					}
				}
				
				updateBalance()
				checkSelectedSpaceship()
								
			}
			
			if node == setupIndex {
			
				if spaceshipNum == 1 {
					startGame()
				}
				
				if spaceshipNum == 2 {
					if spaceship2IsBought == 1 {
							startGame()
					}
					if spaceship2IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 3 {
					if spaceship3IsBought == 1 {
							startGame()
					}
					if spaceship3IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 4 {
					if spaceship4IsBought == 1 {
							startGame()
					}
					if spaceship4IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 5 {
					if spaceship5IsBought == 1 {
							startGame()
					}
					if spaceship5IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 6 {
					if spaceship6IsBought == 1 {
							startGame()
					}
					if spaceship6IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 7 {
					if spaceship7IsBought == 1 {
							startGame()
					}
					if spaceship7IsBought == 0 {
							buySpaceship()
					}
				}
				
				if spaceshipNum == 8 {
					if spaceship8IsBought == 1 {
							startGame()
					}
					if spaceship8IsBought == 0 {
							buySpaceship()
					}
				}
				
				updateBalance()
				checkSelectedSpaceship()
							
			}
			
			if node == homeButton {
			
				let transition:SKTransition = SKTransition.fade(withDuration: 0)
				let scene:SKScene = MenuScene(size: self.size)
				self.view?.presentScene(scene, transition: transition)
			
			}
			
            if node == changeSpaceshipLeftButton {
            
				spaceshipNum = spaceshipNum - 1
				
				if spaceshipNum < 1 {
					spaceshipNum = 8
				}
				
				if spaceshipNum > 8 {
					spaceshipNum = 1
				}
				
				checkSelectedSpaceship()
				
			}
			
            if node == changeSpaceshipRightButton {
            
				spaceshipNum = spaceshipNum + 1
	
				if spaceshipNum < 1 {
					spaceshipNum = 8
				}
				
				if spaceshipNum > 8 {
					spaceshipNum = 1
				}
				
				checkSelectedSpaceship()
				
			}
		}
	
	
	
	
	
	
	}
}
