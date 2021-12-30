//
//  EarthNode.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 15/12/21.
//

import SceneKit

class EarthNode: SCNNode {

    
    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 1)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Diffuse")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named: "Specular")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named: "Emission")
        self.geometry?.firstMaterial?.normal.contents = UIImage(named: "Normal")
        
        self.geometry?.firstMaterial?.shininess = 50
        
        // Rotate earth
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 100), around: SCNVector3(x: 0, y: 1, z: 0), duration: 30)
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
     
}

extension SCNNode {
    
    //MARK:- Add Node by its name
    convenience init(named name: String) {
        self.init()
        
        guard  let scene = SCNScene(named: name) else {
            return
        }
        
        for childNode in scene.rootNode.childNodes {
            addChildNode(childNode)
        }
    }
}
