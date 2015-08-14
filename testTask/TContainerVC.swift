import UIKit


class TContainerVC: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var centrView: UIView!
    var foundationView: UIView!
    var currentView = UIView()
    var currentPavilionName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foundationView = UIView(frame: CGRect(x: 40, y: 40, width: 600, height: 600))
        foundationView.backgroundColor = UIColor.purpleColor()
        foundationView.backgroundColor = UIColor(patternImage: UIImage(named: "pavilion.png")!)
        foundationView.addSubview(scrollView.subviews[0])
        centerScrollViewContents()
        scrollView.addSubview(foundationView)
        scrollView.delegate = self;
        
        
        let n = 3
        let pav1 = TPavilion(name: "Camden Town", x: 0, y: 0, width: 160, height: 150)
        let pav2 = TPavilion(name: "Zoo", x: 280, y: 150, width: 120, height: 120)
        let pav3 = TPavilion(name: "Canal", x: 280, y: 0, width: 120, height: 140)
        let pavs = [pav1, pav2, pav3]
        for pav in pavs {
            let room = Room(pavailion: pav)
            room.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAct:"))
            foundationView.addSubview(room)
        }
    }
    
    func centerScrollViewContents() {
        let scrSize = scrollView.frame.size
        var scFrame = foundationView.frame
        if scFrame.size.width < scrSize.width {
            scFrame.origin.x = (scrSize.width - scFrame.size.width) / 2.0 }
        else { scFrame.origin.x = 0.0 }
        if scFrame.size.height < scrSize.height {
            scFrame.origin.y = (scrSize.height - scFrame.size.height) / 2.0 - 60 }
        else { scFrame.origin.y = -60.0 }
        foundationView.frame = scFrame
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return foundationView
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    
    func tapAct (gesture: UIGestureRecognizer) {
        if let roomFrame = (gesture as? UITapGestureRecognizer)?.view?.frame {
            currentView.layer.borderColor = UIColor.blackColor().CGColor
            centrView.frame.origin = CGPoint(x: roomFrame.origin.x + roomFrame.width/2, y: roomFrame.origin.y + roomFrame.height/2)
            currentView = ((gesture as? UITapGestureRecognizer)?.view)!
            currentPavilionName = (currentView as! Room).name
            self.performSegueWithIdentifier("seguePavilion", sender: self)
            (gesture as! UITapGestureRecognizer).view!.layer.borderColor = UIColor.yellowColor().CGColor
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "seguePavilion" {
            if let popoverController = (segue.destinationViewController ).popoverPresentationController {
                popoverController
                popoverController.delegate = self
            }
        }
    }
    

    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

