import UIKit
import YelpSearch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
    let resultsController = YelpResultsTableViewController()
    let navigationController = UINavigationController(rootViewController: resultsController)
    UINavigationBar.appearance().barTintColor = UIColor.redColor()
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    
    
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window!.rootViewController = navigationController
    window!.makeKeyAndVisible()
    
    return true
  }
  
}

