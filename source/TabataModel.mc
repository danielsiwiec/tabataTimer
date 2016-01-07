using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;

class Model{

	var round = 0;
	var phase = :rest;
	var done = false;
	var phaseTimer = new Timer.Timer();
	var startTime;
	var timer = new Timer.Timer();
	var minutesFromStart = 0;
	var secodsFromStart = 0;
	const WORK_TIME = 2;
	const REST_TIME = 1;
	const TOTAL_ROUNDS = 8;

	function start(){
		startTime = Toybox.System.getTimer();
		timer.start(method(:onTimer), 1000, true);
		phaseTimer.start(method(:onPhaseTimer), REST_TIME*1000, false);
		buzz();
		Ui.requestUpdate();
	}
	
	// show elapsed time
	function onTimer(){
		Ui.requestUpdate();
	}
	
	function onPhaseTimer(){
		if (round == TOTAL_ROUNDS) {
			done = true;
			timer.stop();
			phaseTimer.stop();
		} else {
			if (phase == :rest){
				resetTimer(WORK_TIME);
				phase = :work;
				round = round + 1;
			} else {
				resetTimer(REST_TIME);
				phase = :rest;
			}
		}
		buzz();
		Ui.requestUpdate();
	}
	
	function resetTimer(seconds){
		phaseTimer.start(method(:onPhaseTimer), seconds*1000, false);
	}
	
	function buzz(){
		Toybox.System.println("Buzzed on: " + timerString());
		var vibrateData = [ new Attention.VibeProfile(  50, 1000 ) ];
	    Attention.vibrate( vibrateData );
	}
	
	function timerString(){
		var elapsedMillis = Toybox.System.getTimer() - startTime;
    	var seconds = elapsedMillis / 1000;
    	var minutes = seconds/60;
    	var secondsOfAMinute = seconds - minutes * 60;
    	return minutes.format("%d") + ":" + secondsOfAMinute.format("%02d");
	}
}