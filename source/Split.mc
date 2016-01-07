using Toybox.WatchUi as Ui;

class SplitView extends Ui.View{

	function initialize(mdl) {
        View.initialize();
    }
	
	function onLayout(dc) {
		setLayout(Rez.Layouts.SplitLayout(dc));
	}
}

class SplitDelegate extends Ui.BehaviorDelegate{
	
	function onSelect(){
		var model = new Model();
		model.start();
		Ui.switchToView(new TimerView(model), new TimerDelegate(model), Ui.SLIDE_IMMEDIATE); 
		return true;
	}
}