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
	
	
}