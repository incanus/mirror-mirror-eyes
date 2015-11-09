import UIKit
import Parse
import GPUImage

class ViewController: UIViewController {

    var camera: GPUImageVideoCamera!
    var filter: GPUImageMotionDetector!
    var motion = false
    var lastMotion = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()

        camera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Front)
        camera.outputImageOrientation = .PortraitUpsideDown
        camera.horizontallyMirrorFrontFacingCamera = false
        camera.horizontallyMirrorRearFacingCamera = false

        filter = GPUImageMotionDetector()
        filter.motionDetectionBlock = { [unowned self] centroid, intensity, frameTime in
            if intensity > 0.1 {
                self.motion = true
            } else {
                self.motion = false
                if self.lastMotion == false {
                    return
                }
            }

            PFPush.sendPushMessageToQueryInBackground(PFInstallation.query()!,
                withMessage: "\(self.motion)")

            self.lastMotion = self.motion

            print("motion: \(self.motion)")
        }

        camera.addTarget(filter)
        camera.startCameraCapture()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
