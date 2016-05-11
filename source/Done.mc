using Toybox.WatchUi as Ui;

class DoneView extends Ui.View{

	function initialize() {
    View.initialize();
  }

	function onLayout(dc) {
		setLayout(Rez.Layouts.DoneLayout(dc));
	}
}

class DoneDelegate extends Ui.BehaviorDelegate {

	function initialize() {
		BehaviorDelegate.initialize();
	}

	function onSelect(){
		var model = new Model();
		Ui.switchToView(new TimerView(model), new TimerDelegate(model), Ui.SLIDE_IMMEDIATE);
		return true;
	}
}
