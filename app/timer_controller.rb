class TimerController < UIViewController
  def loadView
    self.view = TimerView.alloc.init
  end

  def shouldAutorotateToInterfaceOrientation(*)
    true
    # showPreferences
  end
  
  def showPreferences
    controller = UIApplication.sharedApplication.delegate.preferences_controller
    navigationController = UINavigationController.alloc.initWithRootViewController(controller)
    navigationController.pushViewController(controller, animated:true)
  end
end