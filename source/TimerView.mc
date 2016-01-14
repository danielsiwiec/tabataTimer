using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class TimerView extends Ui.View {

    var model;
    
    function initialize(mdl) {
    	model = mdl;
        View.initialize();
    }

    function onUpdate(dc) {
    	setupDisplay(dc, model.phase);
    	if (model.done){
    		Ui.switchToView(new DoneView(model), new DoneDelegate(model), Ui.SLIDE_IMMEDIATE);
    	} else {
    		updateTime(dc);
	    	bottomText("" + model.round + "/" + model.TOTAL_ROUNDS, dc);
	    	if (model.round == 0) {
	    		topText("prep", dc);
	    	} else {
	    		if (model.phase == :rest){
		    		topText("rest", dc);
		    	} else {
		    		topText("GO", dc);
		    	}	
	    	}
	    	
    	}
    }
    
    function updateTime(dc){
    	largeText(model.timerString(), dc);
    	
    }
    
    function setupDisplay(dc, phase){
    	if (phase == :work) {
    		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
    	} else {
    		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);	
    	}
        dc.clear();
    }
    
    function topText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.1, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function bottomText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.8, Gfx.FONT_LARGE, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    function largeText(text, dc){
    	dc.drawText(dc.getWidth()/2, dc.getHeight()*0.25, Gfx.FONT_NUMBER_THAI_HOT, text, Gfx.TEXT_JUSTIFY_CENTER);
    }
}
