//
//  ContentView.swift
//  coreml-tests
//
//  Created by Todd Rylaarsdam on 6/21/22.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    var body: some View {
        Button("Run model") {
            runModelOnImage()
        }
    }
    
    func runModelOnImage() {
        do {
            let model = try VNCoreMLModel(for: MobileNet().model)
            let request = VNCoreMLRequest(model: model, completionHandler: myResultsMethod)
            let handler = VNImageRequestHandler(url: URL(string: "https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=1200")!)
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    func myResultsMethod(request: VNRequest, error: Error?) {
        guard let results = request.results as? [VNClassificationObservation]
            else { fatalError("huh") }
        for classification in results {
            print(classification.identifier, // the scene label
                  classification.confidence)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
