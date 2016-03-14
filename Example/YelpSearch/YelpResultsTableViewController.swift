import UIKit
import YelpSearch

public class YelpResultsTableViewController: UITableViewController {

    var yelpClient: YelpClient?

    var isLoading = false
    var businesses = [YelpBusiness]()

    public init() {
        super.init(nibName: nil, bundle: nil)
        try! initializeYelpClient()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Businesses"

        addRefreshButtonToNavBar()
    }

    func refreshBusinesses() {
        if (isLoading) {
            return
        }

        print("Running Search")
        isLoading = true
        let request = YelpSearchRequest()
        let coordinate = YelpLatLong(latitude: "37.4476340", longitude: "-122.1609400")
        let location = YelpLocationParameter.Coordinate(coordinate: coordinate, accuracy: nil, altitude: nil, altitudeAccuracy: nil)

        // This is running a search to find the 10 nearest businesses to the coordinates of the address 431 Waverley Street, Palo Alto, CA
        request.setLocation(location)
        .setLimit(10)
        .setSortOrder(YelpSearchOrder.Distance)
        .setRadiusFilterInMeters(50)

        do {
            try yelpClient!.makeSearchRequest(request, success: {
                (results: YelpSearchResults) in
                self.handleBusinessRequestSuccess(results)
            }, failure: {
                (error: NSError) in
                self.handleBusinessRequestError(error)
            })
        } catch {
            print("ERROR!")
        }
    }

    private func addRefreshButtonToNavBar() {
        let refreshButton: UIButton = UIButton(type: UIButtonType.Custom) as UIButton
        refreshButton.addTarget(self, action: "refreshBusinesses", forControlEvents: UIControlEvents.TouchUpInside)
        refreshButton.setTitle("Refresh", forState: UIControlState.Normal)
        refreshButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        refreshButton.sizeToFit()
        let refreshButtonItem: UIBarButtonItem = UIBarButtonItem(customView: refreshButton)
        self.navigationItem.leftBarButtonItem = refreshButtonItem
    }

    //# MARK - YelpClient initialization
    func initializeYelpClient() throws {
        // Keys are read in from the YelpKeys.plist file. Before you can run this example, you need to
        // edit that plist to include your keys or put them inline.
        guard let path = NSBundle.mainBundle().pathForResource("YelpKeys", ofType: "plist"),
        dict = NSDictionary(contentsOfFile: path) as? [String:AnyObject] else {
            throw ExampleError.MissingYelpKeysPlist
        }

        guard let consumerKey = dict["ConsumerKey"] as! String?,
        consumerSecret = dict["ConsumerSecret"] as! String?,
        accessToken = dict["AccessToken"] as! String?,
        accessTokenSecret = dict["AccessTokenSecret"] as! String? else {
            throw ExampleError.MissingOAuthKeys
        }

        let oauthToken = YelpOAuthToken(consumerKey: consumerKey, consumerSecret: consumerSecret,
                accessToken: accessToken, accessTokenSecret: accessTokenSecret)

        self.yelpClient = YelpClient(oauthToken: oauthToken)
    }

    //# MARK - Request success and failure
    private func handleBusinessRequestSuccess(results: YelpSearchResults) {
        self.isLoading = false
        switch (results) {
        case .Success(let businesses, let total):
            print("\(total) businesses found")
            self.businesses = businesses
            self.tableView.reloadData()
            break
        case .Error(let error):
            // Received a response from Yelp, but that response indicates that the request
            // violated some business logic
            let alert = UIAlertController(title: "Error", message: "Invalid Request. See Yelp documentation.\n \(error.errorType) \n \(error.errorText) \n \(error.field)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { _ in }))
            self.presentViewController(alert, animated: true, completion: nil)
            break
        }
    }

    private func handleBusinessRequestError(error: NSError) {
        self.isLoading = false
        let alert = UIAlertController(title: "Error", message: "Error making request", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { _ in }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    //# MARK - TableviewController Methods

    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "ResultCell")
        cell.textLabel!.text = businesses[indexPath.row].name

        return cell
    }

    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }

    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let business = businesses[indexPath.row]
        let detailViewController = YelpBusinessDetailViewController(business: business)
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }

}
