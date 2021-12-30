//
//  AsteroidDetailsViewController.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 18/12/21.
//

import UIKit
import SceneKit

class AsteroidDetailsViewController: UIViewController {
    
    //MARK:- Variables
    var asteroidName:String?
    var orbitingBody:String?
    var hazardous:String?
    var firstObservationDate:String?
    var lastObservationDate:String?
    
    var neoReferenceID:String?
    var orbitID:String?
    var kilometersPerHour: String?
    var kilometersPerSecond: String?
    
    let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var headingNameLbl: UILabel = {
        var name = UILabel()
        name.textColor = .white
        name.textAlignment = .center
        name.numberOfLines = 0
        name.font = UIFont(name: "Kefa-Regular", size: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var bottomTable: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var moreBtn: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Kefa-Regular", size: 16)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor(red: 30/255, green: 29/255, blue: 15/255, alpha: 1.0).cgColor
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSceneKit()
    }
    
    //MARK:- Setup Scenekit and Nodes
    private func setUpSceneKit() {
        //   Scene kit node
        let scene = SCNScene()
        
        // Scene View
        let sceneView = self.view as? SCNView
        sceneView!.scene = scene
        sceneView!.showsStatistics = false
        sceneView!.backgroundColor = .black
        sceneView!.allowsCameraControl = true
        
        // Subviews
        sceneView?.addSubview(exitButton)
        sceneView?.addSubview(headingNameLbl)
        sceneView?.addSubview(table)
        sceneView?.addSubview(bottomTable)
        sceneView?.addSubview(moreBtn)
        
        //   Camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        // Light node
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 2)
        scene.rootNode.addChildNode(lightNode)
        
        // Particle node
        let particleNode = SCNParticleSystem(named: "StarsParticles.scnp", inDirectory: nil)
        scene.rootNode.addParticleSystem(particleNode!)
        
       // Node for asteroid
        let node = SCNNode(named: "asteroid.scnassets/asteroid.dae")
        let action = SCNAction.rotate(by: 180 * CGFloat(Double.pi / 100), around: SCNVector3(x: 0, y: 1, z: 0), duration: 50)
        let repeatAction = SCNAction.repeatForever(action)
        node.runAction(repeatAction)
        scene.rootNode.addChildNode(node)
        setUpView()
    }
    
    //MARK:- Setup views
    private func setUpView() {
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.register(UINib(nibName: "AsteroidTopCell", bundle: nil), forCellReuseIdentifier: "AsteroidTopCell")
        // Target for buttons
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        moreBtn.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        addAnimations()
    }

    //MARK:- Animations
    private func addAnimations() {
        self.viewWillLayoutSubviews()
        UIView.animate(withDuration: 1, animations: { [self] in
            // From left animation
            exitButton.center.x = view.center.x
            self.viewWillLayoutSubviews()
           
        })
        
        self.moreBtn.fadeOut { (true) in
            self.moreBtn.setTitle("more", for: .normal)
            self.moreBtn.backgroundColor = .white
            self.moreBtn.fadeIn()
        }
        self.headingNameLbl.fadeOut { (true) in
            self.headingNameLbl.text = self.asteroidName
            self.headingNameLbl.fadeIn()
        }
        self.headingNameLbl.fadeOut { (true) in
            self.headingNameLbl.text = self.asteroidName
            self.headingNameLbl.fadeIn()
        }
    }
    
    @objc func exitButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func moreButtonTapped(_ sender: UIButton) {
        if bottomTable.isHidden == true {
            bottomTable.isHidden = false
            bottomTable.delegate = self
            bottomTable.dataSource = self
            bottomTable.separatorStyle = .none
            bottomTable.backgroundColor = .clear
            bottomTable.register(UINib(nibName: "AsteroidBottomCell", bundle: nil), forCellReuseIdentifier: "AsteroidBottomCell")
            bottomTable.reloadData()
            moreBtn.setTitle("less", for: .normal)
        }
        else {
            self.bottomTable.fadeOut()
            moreBtn.setTitle("more", for: .normal)
        }
    }
    
}

extension AsteroidDetailsViewController {
    //MARK:- Layout Views
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        exitButton.trailingAnchor.constraint(equalTo: headingNameLbl.leadingAnchor, constant: 20).isActive = true
        
        headingNameLbl.leadingAnchor.constraint(equalTo: exitButton.trailingAnchor, constant: 20).isActive = true
        headingNameLbl.centerYAnchor.constraint(equalTo: exitButton.centerYAnchor, constant: 0).isActive = true
        headingNameLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        headingNameLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        table.topAnchor.constraint(equalTo: exitButton.bottomAnchor, constant: 20).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        table.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        bottomTable.bottomAnchor.constraint(equalTo: moreBtn.topAnchor, constant: -10).isActive = true
        bottomTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomTable.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        moreBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        moreBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        moreBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        moreBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
 
}

//MARK:- TableView Delegates
extension AsteroidDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == table {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidTopCell",for: indexPath) as! AsteroidTopCell
            // Animations
            cell.orbitingBodyLbl.fadeOut { (true) in
                cell.orbitingBodyLbl.text = self.orbitingBody
                cell.orbitingBodyLbl.fadeIn()
            }
            
            cell.hazardousLbl.fadeOut { (true) in
                if self.hazardous == "false" {
                    cell.hazardousLbl.text = "NO"
                    cell.hazardousLbl.textColor = .systemGreen
                }
                else if self.hazardous == "true" {
                    cell.hazardousLbl.text = "YES"
                    cell.hazardousLbl.textColor = .red
                }
                cell.hazardousLbl.fadeIn()
            }
            
            cell.firstObservationLbl.fadeOut { (true) in
                cell.firstObservationLbl?.text = self.firstObservationDate
                cell.firstObservationLbl.fadeIn()
            }
            cell.lastObservationLbl.fadeOut { (true) in
                cell.lastObservationLbl?.text = self.lastObservationDate
                cell.lastObservationLbl.fadeIn()
            }
            
            self.viewWillLayoutSubviews()
            UIView.animate(withDuration: 1, animations: { [self] in
                // From left animation
                cell.orbitingBodyTitleLbl?.center.x = view.center.x
                cell.hazardousTitleLbl?.center.x = view.center.x
                cell.firstObservationTitleLbl?.center.x = view.center.x
                cell.lastObservationTitleLbl?.center.x = view.center.x
                
                self.viewWillLayoutSubviews()
                
            })
            // cell settings
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidBottomCell") as! AsteroidBottomCell
            // Animations
            cell.orbitIDLbl.fadeOut { (true) in
                cell.orbitIDLbl?.text = self.orbitID
                cell.orbitIDLbl.fadeIn()
            }
            
            cell.neoReferenceIdLbl.fadeOut { (true) in
                cell.neoReferenceIdLbl?.text = self.neoReferenceID
                cell.neoReferenceIdLbl.fadeIn()
            }
            
            cell.kilometersPerHourDistanceLbl.fadeOut { (true) in
                let distance = Double(self.kilometersPerHour!)
                cell.kilometersPerHourDistanceLbl?.text = String(format: "%.2f", distance!)
                cell.kilometersPerHourDistanceLbl.fadeIn()
            }
            
            cell.kilometersPerSecondDistanceLbl.fadeOut { (true) in
                let distance = Double(self.kilometersPerSecond!)
                cell.kilometersPerSecondDistanceLbl?.text = String(format: "%.2f", distance!)
                cell.kilometersPerSecondDistanceLbl.fadeIn()
            }
            
            self.viewWillLayoutSubviews()
            UIView.animate(withDuration: 1, animations: { [self] in
                // From left animation
                cell.orbitIDTitleLbl?.center.x = view.center.x + 50
                cell.neoReferenceIdTitleLbl?.center.x = view.center.x + 50
                cell.kilometersPerHourTitleDistanceLbl?.center.x = view.center.x
                cell.kilometersPerSecondTitleDistanceLbl?.center.x = view.center.x
                self.viewWillLayoutSubviews()
                
            })
            // cell settings
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            return cell
        }
    }
    
}

