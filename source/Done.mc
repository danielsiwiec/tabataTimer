using Toybox.WatchUi as Ui;

class DoneView extends Ui.View{

	function initialize(mdl) {
        View.initialize();
    }
	
	function onLayout(dc) {
		setLayout(Rez.Layouts.DoneLayout(dc));
	}
}

class DoneDelegate extends Ui.BehaviorDelegate{
	
	function onSelect(){
		var model = new Model();
		Ui.switchToView(new SplitView(), new SplitDelegate(), Ui.SLIDE_IMMEDIATE); 
		return true;
	}
}