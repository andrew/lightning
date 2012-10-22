class PreferencesController < UIViewController
  def loadView
    self.view = PreferencesView.alloc.init
  end

  def shouldAutorotateToInterfaceOrientation(*)
    true
  end
end