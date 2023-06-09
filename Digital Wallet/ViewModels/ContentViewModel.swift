/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import CoreImage
import UIKit

class ContentViewModel: ObservableObject {
  @Published var error: Error?
  @Published var frame: CGImage?
  @Published var hasSmile =  false

  var comicFilter = false
  var monoFilter = false
  var crystalFilter = false

  private let context = CIContext()

  private let cameraManager = CameraManager.shared
  private let frameManager = FrameManager.shared

  init() {
    setupSubscriptions()
  }

  func setupSubscriptions() {
    // swiftlint:disable:next array_init
    cameraManager.$error
      .receive(on: RunLoop.main)
      .map { $0 }
      .assign(to: &$error)

    frameManager.$current
      .receive(on: RunLoop.main)
      .compactMap { buffer in
        guard let image = CGImage.create(from: buffer) else {
          return nil
        }

        let ciImage = CIImage(cgImage: image)

        let options: [String : Any] = [CIDetectorAccuracy: CIDetectorAccuracyLow,
//                                       CIDetectorTracking: true,
                                       CIDetectorNumberOfAngles: 11]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)
          
//        let imageOptions =  NSDictionary(object: NSNumber(value: 5) as NSNumber, forKey: CIDetectorImageOrientation as NSString)
//        let faces = faceDetector?.features(in: ciImage, options: imageOptions as? [String : AnyObject])
        let faces = faceDetector?.features(in: ciImage, options: [CIDetectorSmile : true])
          
        if let face = faces?.first as? CIFaceFeature {
            print("face bounds are \(face.bounds)")
            if face.hasSmile {
                print("Found smile at \(face.hasSmile)")
            }
//            let alert = UIAlertController(title: "Say Cheese!", message: "We detected a face!", preferredStyle: UIAlertController.Style.alert)
//            //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            let confirmAction = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(confirmAction)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alert.addAction(cancelAction)
//            self.present(alert, animated: true, completion: nil)
        }
//          else {
//           let alert = UIAlertController(title: "No Face!", message: "No face was detected", preferredStyle: UIAlertController.Style.alert)
//              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//              self.present(alert, animated: true, completion: nil)
//        }
          
//        if self.comicFilter {
//          ciImage = ciImage.applyingFilter("CIComicEffect")
//        }
//
//        if self.monoFilter {
//          ciImage = ciImage.applyingFilter("CIPhotoEffectNoir")
//        }
//
//        if self.crystalFilter {
//          ciImage = ciImage.applyingFilter("CICrystallize")
//        }

        return self.context.createCGImage(ciImage, from: ciImage.extent)
      }
      .assign(to: &$frame)
  }
}
