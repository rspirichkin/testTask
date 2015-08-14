//
//  TPavilion.swift
//  testTask
//
//  Created by Roman Spirichkin on 8/14/15.
//  Copyright © 2015 Perfect Ware Development. All rights reserved.
//
import UIKit

class TPavilion : NSObject {
    let name : String
    let x, y, width, height : Int
    
    init(name: String, x: Int, y: Int, width: Int, height : Int) {
        self.name = name
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    func rect() -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

class Room : UIView {
    var name = "room"
    
    init(pavailion: TPavilion) {
        super.init(frame: pavailion.rect())
        super.layer.borderWidth = 2

        name = pavailion.name
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
