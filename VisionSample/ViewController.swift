//
//  ViewController.swift
//  VisionSample
//
//  Created by 丸本聡 on 2020/03/21.
//  Copyright © 2020 丸本聡. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let image = UIImage(named: "nifty")
        guard let cgImage = image?.cgImage else { return }
        let request = VNRecognizeTextRequest(completionHandler: self.recognizeTextHandler)
        
        request.recognitionLevel = .fast  // .accurate と .fast が選択可能
        request.recognitionLanguages = ["en_US"] // 言語を選ぶ
        request.usesLanguageCorrection = true // 訂正するかを選ぶ
        
        let requests = [request]
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,  options: [:])
        
        do {
            try imageRequestHandler.perform(requests)
        } catch {
            print("error")
        }
    }
    
    func recognizeTextHandler(request: VNRequest?, error: Error?) {
        guard let observations = request?.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        var text = ""

        for observation in observations {
            let candidates = 1
            guard let bestCandidate = observation.topCandidates(candidates).first else {
                continue
            }
            
            text = bestCandidate.string // 文字認識結果
        }
        
        label.text = text
    }
}

