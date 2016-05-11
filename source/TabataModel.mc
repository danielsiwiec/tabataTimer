using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

class Model{

	const REST_TIME = 10;
	const PREP_TIME = REST_TIME;
	const WORK_TIME = REST_TIME * 2;
	const TOTAL_ROUNDS = 8;

	var counter = PREP_TIME;
	var round = 0;
	var phase = :prep;
	var done = false;
	var session = ActivityRecording.createSession({:sport => ActivityRecording.SPORT_TRAINING, :subSport => ActivityRecording.SUB_SPORT_CARDIO_TRAINING, :name => "Tabata"});

	hidden var refreshTimer = new Timer.Timer();
	hidden var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);

	function start(){
		refreshTimer.start(method(:refresh), 1000, true);
		buzz(1000, Attention.TONE_START);
		Ui.requestUpdate();
	}

	function refresh(){
		if (counter > 1){
			counter--;
		} else {
			if (phase == :prep) {
				session.start();
				phase = :work;
				counter = WORK_TIME;
				round++;
				buzz(500, Attention.TONE_LOUD_BEEP);
			} else if (phase == :work) {
				phase = :rest;
				counter = REST_TIME;
				buzz(500, Attention.TONE_LOUD_BEEP);
			}	else if (phase == :rest) {
				if (round == TOTAL_ROUNDS){
					finishUp();
					buzz(1500, Attention.TONE_STOP);
				} else {
					phase = :work;
					counter = WORK_TIME;
					round++;
					buzz(500, Attention.TONE_LOUD_BEEP);
				}
			}
		}
		Ui.requestUpdate();
	}

	function finishUp() {
		done = true;
		session.stop();
		session.save();
		refreshTimer.stop();
	}

	function buzz(duration, tone){
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
    Attention.vibrate( vibrateData );
		Attention.playTone(tone);
	}
}
