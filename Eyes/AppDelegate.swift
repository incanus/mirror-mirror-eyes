import UIKit
import Parse

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("<your parse app id>",
            clientKey: "<your parse client key>")

        UIApplication.sharedApplication().idleTimerDisabled = true

        return true
    }

}
