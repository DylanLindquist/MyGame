//
//  ContentView.swift
//  MyGame
//
//  Created by Lindquist, Dylan on 1/12/21.
//

import SwiftUI
import SpriteKit

struct DropGameView: View
{
    private let width : CGFloat = 300
    private let height : CGFloat = 400
    
    private var simpleScene : GameScene
    {
        let scene = GameScene()
        scene.size = CGSize(width: width, height: height)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View
    {
        SpriteView(scene: simpleScene)
            .frame(width: width, height: height)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        DropGameView()
    }
}
