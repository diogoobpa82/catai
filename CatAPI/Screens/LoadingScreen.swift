//
//  LoadingScreen.swift
//  CatAPI
//
//  Created by Diogo Aguiar on 04/07/2023.
//

import UIKit

class LoadingScreen: UIViewController
{
    lazy var container:UIView = { let view = UIView(); view.backgroundColor = UIColor.clear;return view }()
    
    lazy var circleA:UIView = { let view = UIView(); view.backgroundColor = UIColor.systemYellow; return view }()
    lazy var circleA1:UIView = { let view = UIView(); view.backgroundColor = UIColor.systemYellow; return view }()
    lazy var circleB:UIView = { let view = UIView(); view.backgroundColor = UIColor.systemBlue; return view }()
    lazy var circleB1:UIView = { let view = UIView(); view.backgroundColor = UIColor.systemBlue; return view }()
    
    lazy var circles = [circleA,circleA1,circleB,circleB1]
    
    let stt = UILabel(fontSize: 22, textColor: UIColor.darkBlue, alignment: .center)
    
    var number = 0
    
    override func viewDidLoad() {
        setupViews()
        setupAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stt.text = "Loading data"
        checkInternet{
            getBreeds()
        }
    }
    
    func setupViews()
    {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.blue.cgColor, UIColor.lightBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x : 0.0, y : 0.4)
        gradient.endPoint = CGPoint(x :0.0, y: 1.0)
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        for circle in circles {
            circle.layer.cornerRadius = 10
            circle.isUserInteractionEnabled = false
        }
        
        container.isUserInteractionEnabled = false
    
        view.addSubview(container)
       
        container.addSubview(circleA)
        container.addSubview(circleA1)
        container.addSubview(circleB)
        container.addSubview(circleB1)
        
        view.addSubview(stt)
        
        container.anchor(view.centerYAnchor, left: view.centerXAnchor, bottom: nil, right: nil, topConstant: -40, leftConstant: -40, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 80)
        
        circleA.anchor(container.topAnchor, left: container.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        circleA1.anchor(container.topAnchor, left: nil, bottom: nil, right: container.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        circleB.anchor(nil, left: nil, bottom: container.bottomAnchor, right: container.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        circleB1.anchor(nil, left: container.leftAnchor, bottom: container.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        stt.anchor(container.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        for circle in self.circles{
            circle.backgroundColor = .clear
        }
    }
    
    func setupAnimation(){
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .repeat, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                for circle in self.circles{
                    circle.backgroundColor = .clear
                }
                
                self.circles[0].backgroundColor = UIColor.darkBlue
            }

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 1) {
                for circle in self.circles{
                    circle.backgroundColor = .clear
                }
                
                self.circles[1].backgroundColor = UIColor.darkBlue
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                for circle in self.circles{
                    circle.backgroundColor = .clear
                }
                
                self.circles[2].backgroundColor = UIColor.darkBlue
            }

            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1) {
                for circle in self.circles{
                    circle.backgroundColor = .clear
                }
                
                self.circles[3].backgroundColor = UIColor.darkBlue
            }
        })
    }
}
