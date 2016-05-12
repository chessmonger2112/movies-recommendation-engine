//
//  ViewController.swift
//  movies
//
//  Created by Kyle Smith on 4/7/16.
//  Copyright © 2016 Kyle Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var abstractLabel: UILabel!
    var computation = Computation()
    
    func findConnections(featured : Int) {
        let siblings = nodes[featured]["links"] as! Array<Int> //array of the indicies of the featured film's siblings
        for sibling in siblings {
            let siblingsSiblings = nodes[sibling]["links"] as! Array<Int>
            for siblingsSibling in siblingsSiblings {
                if siblings.contains(siblingsSibling) {
                    let point1 = getPositionFromIndex[sibling]!
                    let point2 = getPositionFromIndex[siblingsSibling]!
                    
                    drawLineWithFromPointOneToPointTwo(point1, point2: point2)
                }
            }
        }
    }
    
    
    func click(sender: UIButton) { //this is what happens when a featured movie is clicked
        let title = sender.titleLabel!.text!
        let index = computation.getIndexFromTitle(title)
        featured = index
        print ("\(title) was clicked")
        eraseButtons()
        eraseLayers()
        let currentMovie = nodes[featured]
        let links = currentMovie["links"] as! Array<Int>
        createLinks(links)
        updateAbstract()
        findConnections(featured)
//        changeFeaturedsTitle()
    }
    func updateAbstract(){ //belongs in the view
        abstractLabel.text = getAbstractFromIndex(featured)
    }
    func getTitleFromIndex (index : Int) -> String {
        return nodes[index]["title"] as! String
    }
    func eraseButtons(){ //belongs in the view
        for view in self.view.subviews {
//            print("view is \(view)")
            let tag = view.tag
            if tag == RELATEDTAG {
                view.removeFromSuperview()
            }
            else if tag == 69 {
                let button = self.view.viewWithTag(69) as! UIButton
                let title = getTitleFromIndex(featured)
                button.setTitle(title, forState: UIControlState.Normal)
            }
        }
    }
    
    func eraseLayers() { //belongs in the view
        for layer in view.layer.sublayers! {
            if layer is CAShapeLayer{
                layer.removeFromSuperlayer()
            }
        }
    }

    func changeFeaturedsTitle() {
        print("supppp: \(self.view.subviews.count)")
        for view in self.view.subviews {
            let tag = view.tag
            if tag == 69 {
                let button = self.view.viewWithTag(69) as! UIButton
                let title = getTitleFromIndex(featured)
                button.setTitle(title, forState: UIControlState.Normal)
            }
        }
    }
    
    func getAbstractFromIndex (index : Int) -> String {
        let movie = nodes[index]
        let abstract = movie["abstract"] as! String
        return abstract
    }
    
    
    func drawLineWithFromPointOneToPointTwo (point1 : (Int, Int), point2 :(Int, Int)) {
        let x1 = point1.0
        let y1 = point1.1
        let x2 = point2.0
        let y2 = point2.1
        var deltaX = Double(x2 - x1)
        let deltaY = Double(y2 - y1)
        if deltaX == 0 {
            deltaX = 0.0001
        }
        let m = deltaY / deltaX
        let b = Double(y1) - m * Double(x1)        
        
        if x1 < x2 {
            for pointX in x1 ... x2 {
                let pointY = m * Double(pointX) + b
                
                makeCircle(Int(pointX), y: Int(pointY))
            }
        }
    }
    
    
    func makeFeaturedButton(title : String) { //belongs in the view
        let button = UIButton(type: UIButtonType.System)
        button.setTitle(title, forState: UIControlState.Normal)
        button.tag = 69
        button.titleLabel!.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        button.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    }
    let defaultY = 50
    var yPos = 50   //height is about 710, halfway point: 360
    func makeButton(title : String, x : Int, y : Int) //belongs in the view
    {
        let button = UIButton(type: UIButtonType.System)
        button.titleLabel!.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 14)
        button.setTitle(title, forState: UIControlState.Normal)
        button.tag = RELATEDTAG
        view.addSubview(button)
        let width = 100
        button.frame = CGRect(x: centerX + x - width / 2, y: centerY + y, width: width, height: 30)
        yPos += 20
        button.addTarget(self, action: "click:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    let RELATEDTAG = 1
    
    var getPositionFromIndex = [Int : (Int, Int)]()
    func createLinks(links : Array<Int>) {
        var counter = 0
        for index in links {
            let relatedMovie = nodes[index]
            let title = relatedMovie["title"]! as! String
            let coordinates = computation.calculateCoordinates(links.count, i: counter)
            getPositionFromIndex[index] = coordinates
            let Xcoordinate = coordinates.0
            let YCoordinate = coordinates.1
            makeButton(title, x: Xcoordinate, y: YCoordinate)
            counter += 1
        }
        print("calculated coordinates: \(computation.calculateCoordinates(3, i: 1))")
        yPos = defaultY
    }
    
    func makeCircle(x : Int, y : Int) //belongs in the view
    {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x + centerX, y: y + centerY), radius: CGFloat(1), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
        //change the fill color
        shapeLayer.fillColor = UIColor.blueColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.greenColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 0.0
        
        view.layer.addSublayer(shapeLayer)
    }
    
    let centerX = 200
    let centerY = 360
    var nodes = []
    var featured = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let data = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("titles", ofType: "json")!)
        let stringy = String(data: data!, encoding: NSUTF8StringEncoding )
        let newData = stringy!.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonDict = try! NSJSONSerialization.JSONObjectWithData(newData!, options: [])
        var jsonResult = jsonDict as! Dictionary<String, AnyObject> //converts AnyObject to dictionary
        let nodes1 = jsonResult["nodes"]! as! Array<Dictionary<String, AnyObject>> //converts AnyObject to array
        nodes = nodes1
        let title = getTitleFromIndex(featured)
        makeFeaturedButton(title)
        let looper = nodes1[0]
        let links = looper["links"] as! Array<Int>
        createLinks(links)
        let abstract = getAbstractFromIndex(featured)
        abstractLabel.text = abstract
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

