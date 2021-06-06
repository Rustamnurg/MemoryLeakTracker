# MemoryLeakTracker

**MemoryLeakTracker** is a library that helps track memory leaks.

<p align="center">
  <img src="https://raw.githubusercontent.com/Rustamnurg/MemoryLeakTracker/master/gifs/push.gif" alt="Push Example" />
  <img src="https://raw.githubusercontent.com/Rustamnurg/MemoryLeakTracker/master/gifs/alert.gif" alt="Alert Example" />
  <img src="https://raw.githubusercontent.com/Rustamnurg/MemoryLeakTracker/master/gifs/console.gif" alt="Console Example" />
</p>

Leak notification methods:
* Local push notifications
* Alert
* Message on console

## Usage
**MemoryLeakTracker** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```ruby
pod 'MemoryLeakTracker'
```

In the AppDelegate file you need to add
```Swift
import MemoryLeakTracker
```

```Swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let configs = MLKConfiguration(
        isEnable: true,
        notificationType: [.push, .console, .alert],
        messageTrigger: 2
    )
    MemoryLeakTracker.shared.configure(configs)
    setupPushNotifications(on: application)
    setRootViewController()
    return true
}
```

In the observed screens, example

```Swift
import MemoryLeakTracker

class BaseViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MemoryLeakTracker.shared.append("\(self)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        MemoryLeakTracker.shared.append("\(self)")
    }
    
    deinit {
        MemoryLeakTracker.shared.remove("\(self)")
    }
}
```
## Configuration

```Swift
struct MLKConfiguration {
    /// Is the library included
    let isEnable: Bool
    
    /// Ignored classes
    let ignoreClasses: [String]
    
    /// Method of notification:
    /// .push  - local push(you need to set up push notifications in your application!)
    /// .alert - present alert on top screen
    /// .console - print on console
    /// .none - not notify
    let notificationType: [NotificationType]
    
    /// The required number of matches for the assumption of leakage
    let messageTrigger: Int
    
    /// Logging of all library activities in the console
    let logOnConsole: Bool
}
```

You can call a ViewController displaying all the logs
```Swift
let logsViewController = MemoryLeakTrackerController.load()
present(logsViewController, animated: true)
```
<p align="center">
    <img src="https://raw.githubusercontent.com/Rustamnurg/MemoryLeakTracker/master/gifs/allLogs.gif" alt="Example" />
</p>