//
//  AsteroidsListViewController.swift
//  AsteroidNews
//
//  Created by Desktop-simranjeet on 22/12/21.
//

import UIKit
import SceneKit

class AsteroidsListViewController: UIViewController {
    
    //MARK:- Variables
    var sectionIndex:Int?
    let tableHeading = UILabel()
    let dateHeading = UILabel()
    let dataLoadingLbl = UILabel()
    let table = UITableView()
    var asteroidsObj: AsteroidsModel?
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSceneKit()
    }
    
    private func setUpSceneKit() {
        //   Scene kit node
        let scene = SCNScene()
        
        // Scene View
        let sceneView = self.view as? SCNView
        sceneView!.scene = scene
        sceneView!.showsStatistics = false
        sceneView!.backgroundColor = .black
        sceneView!.allowsCameraControl = true
        sceneView!.backgroundColor = .black
        sceneView!.allowsCameraControl = true
        
        // Subviews
        sceneView?.addSubview(table)
        sceneView?.addSubview(tableHeading)
        sceneView?.addSubview(dataLoadingLbl)
        sceneView?.addSubview(dateHeading)
        
        //   Camera node
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 5)
        scene.rootNode.addChildNode(cameraNode)
        
        // Light node
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .area
        lightNode.position = SCNVector3(x: 0, y: 10, z: 2)
        scene.rootNode.addChildNode(lightNode)
        
        // Particle node
        let particleNode = SCNParticleSystem(named: "StarsParticles.scnp", inDirectory: nil)
        scene.rootNode.addParticleSystem(particleNode!)
        
        let earthNode = EarthNode()
        earthNode.position = SCNVector3(x: 2, y: 0, z: 0)
        earthNode.scale = SCNVector3(x: 2, y: 2, z: 2)
        scene.rootNode.addChildNode(earthNode)
        getAsteroidData()
        setUpView()
    }
    
    private func setUpView() {
        Formatter.shared.dateformatter.dateFormat = "yyyy-MM-dd"
        let todayDate =   Formatter.shared.dateformatter.string(from: Formatter.shared.date)
        dateHeading.translatesAutoresizingMaskIntoConstraints = false
        dateHeading.textColor = .white
        dateHeading.textAlignment = .center
        dateHeading.font = UIFont(name: "Kefa-Regular", size: 25)
        dateHeading.text = todayDate
        
        tableHeading.textAlignment = .center
        tableHeading.numberOfLines = 1
        tableHeading.text = "Near Earth Asteroids"
        tableHeading.textColor = .white
        tableHeading.font = UIFont(name: "Kefa-Regular", size: 30)
        tableHeading.translatesAutoresizingMaskIntoConstraints = false
        
        dataLoadingLbl.text = "Fetching data..."
        dataLoadingLbl.font = UIFont(name: "Kefa-Regular", size: 14)
        dataLoadingLbl.textColor = .white
        dataLoadingLbl.translatesAutoresizingMaskIntoConstraints = false
        
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(AsteroidsListCell.self, forCellReuseIdentifier: "AsteroidsListCell")
    }
    
}

extension AsteroidsListViewController {
    
    //MARK:- Layout Views
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableHeading.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        tableHeading.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20).isActive = true
        tableHeading.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant: 30).isActive = true
        
        dateHeading.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        dateHeading.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20).isActive = true
        dateHeading.topAnchor.constraint(equalTo: self.tableHeading.bottomAnchor,constant: 10).isActive = true
        
        dataLoadingLbl.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 0).isActive = true
        dataLoadingLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0).isActive = true
        
        table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -20).isActive = true
        table.topAnchor.constraint(equalTo: self.dateHeading.bottomAnchor,constant: 20).isActive = true
        table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: -20).isActive = true
    }
    
}

//MARK:- TableView Delegates
extension AsteroidsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if asteroidsObj?.nearEarthObjects != nil {
            return (asteroidsObj?.nearEarthObjects!.count)!
        }
        return Int()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidsListCell") as! AsteroidsListCell
        // adding subViews
        cell.contentView.addSubview(cell.backView)
        cell.backView.addSubview(cell.asteroidName)
        cell.backView.addSubview(cell.viewDetailsBtn)
        // set data
        cell.asteroidName.text = "Asteroid: " + (asteroidsObj?.nearEarthObjects![indexPath.row].name)!
        // target for view button
        cell.viewDetailsBtn.addTarget(self, action: #selector(viewDetailsTap), for: .touchUpInside)
        cell.viewDetailsBtn.tag = indexPath.row
        self.sectionIndex = indexPath.section
        // cell settings
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
    @objc private func viewDetailsTap(_ sender: UIButton) {
        let detailedVc = storyboard?.instantiateViewController(identifier: "AsteroidDetailsViewController") as! AsteroidDetailsViewController
        // passing data to details screen
        detailedVc.asteroidName = (asteroidsObj?.nearEarthObjects![sender.tag].name)!
        detailedVc.orbitingBody = (asteroidsObj?.nearEarthObjects![sender.tag].closeApproachData[sectionIndex!].orbiting_body)!
        detailedVc.hazardous = (asteroidsObj?.nearEarthObjects![sender.tag].is_potentially_hazardous_asteroid)!
        detailedVc.firstObservationDate = (asteroidsObj?.nearEarthObjects![sender.tag].orbitalData?.first_observation_date)!
        detailedVc.lastObservationDate = (asteroidsObj?.nearEarthObjects![sender.tag].orbitalData?.last_observation_date)!
        detailedVc.neoReferenceID = (asteroidsObj?.nearEarthObjects![sender.tag].neo_reference_id)!
        detailedVc.orbitID = (asteroidsObj?.nearEarthObjects![sender.tag].orbitalData?.orbit_id)!
        detailedVc.kilometersPerHour = (asteroidsObj?.nearEarthObjects![sender.tag].closeApproachData[sectionIndex!].relativeVelocity?.kilometersPerHour)!
        detailedVc.kilometersPerSecond = (asteroidsObj?.nearEarthObjects![sender.tag].closeApproachData[sectionIndex!].relativeVelocity?.kilometersPerSecond)!
        self.navigationController?.pushViewController(detailedVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


//MARK:- Api Methods
extension AsteroidsListViewController {
    
    //MARK:- Asteroid Neo Api Handler method
    func asteroidAPI(completion:@escaping (AsteroidsModel?,Bool?,String)-> Void) {
        let params:[String:Any] = [
            "detailed":true
        ]
        NetworkManager.getRequest(params: params) {(response) in
            guard response.success ?? false else {
                completion(nil,response.success!, response.message!)
                return
            }
            let asteroidDetails = AsteroidsModel.init(fromJSON: response.responseJSON!["near_earth_objects"])
            completion(asteroidDetails,response.success!, response.message!)
        }
    }
    
    //MARK:- Asteroid Neo Api method
    func getAsteroidData() {
        asteroidAPI { [self] (data, status, message) in
            sleep(2)
            dataLoadingLbl.text = ""
            guard status! else {
                return
            }
            self.asteroidsObj = data
            self.table.reloadData()
            
        }
    }
}





