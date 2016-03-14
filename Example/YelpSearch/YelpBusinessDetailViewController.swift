import UIKit
import YelpSearch

class YelpBusinessDetailViewController: UIViewController{

    var business: YelpBusiness

    convenience init(business: YelpBusiness) {
        self.init(nibName: nil, bundle: nil, business: business)
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, business: YelpBusiness) {
        self.business = business
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // This example doesn't use any storyboards, so if someone tries to initialize this
    // through a storyboard, throw an error
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        // Businesses have various amounts of information associated with them, so almost
        // all fields are optionals, which means lots of unwrapping
        if let name = business.name {
            let businessNameLabel = UILabel()
            businessNameLabel.text = name
            businessNameLabel.sizeToFit()
            self.view.addSubview(businessNameLabel)
            businessNameLabel.center = CGPointMake(self.view.frame.size.width / 2, 100)
        }

        if let location = business.location,
        let address = location.displayAddress where
        address.count > 0 {
            let businessAddressLabel = UILabel()
            businessAddressLabel.text = address[0]
            businessAddressLabel.sizeToFit()
            self.view.addSubview(businessAddressLabel)
            businessAddressLabel.center = CGPointMake(self.view.frame.size.width / 2, 200)
        }

        if let phone = business.displayPhone {
            let businessPhoneLabel = UILabel()
            businessPhoneLabel.text = phone
            businessPhoneLabel.sizeToFit()
            self.view.addSubview(businessPhoneLabel)
            businessPhoneLabel.center = CGPointMake(self.view.frame.size.width / 2, 300)
        }

    }


}
