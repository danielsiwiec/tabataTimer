monkeyc --warn --output bin/tabata.prg -m manifest.xml \
-z resources/drawables/drawables.xml:\
resources/layouts/layout.xml:\
resources/strings/strings.xml \
-d fenix3_sim -u /Users/dsiwiec/connect-iq-sdk-1.2.6/bin/devices.xml \
-p /Users/dsiwiec/connect-iq-sdk-1.2.6/bin/projectInfo.xml \
source/TabataTimerApp.mc \
source/Done.mc \
source/TabataModel.mc \
source/TimerDelegate.mc \
source/TimerView.mc
