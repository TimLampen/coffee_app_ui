# coffee_app_ui

## Design Thinking
During the process of creating this iot-connected coffee machine, I recorded my thought process that was used to come up with the final idea. These thoughts can be viewed here: https://imgur.com/a/c9bHVSF, including some of the other ideas that I Was considering.

## Hardware
Probably the most fun part of the project, just because I was able to apply a lot that I learned during my degree and put it into action. The two main components of the circuit are a 5V relay and ESP8266ESP-01 WiFi module. I was originally going to use an atmega328P (the same processor used in many Arduinos), but it turns out that the ESP8266ESP-01 has more than enough storage to write a program to.

For power, I was hesitant to splice the 120V AC lines coming into the existing coffee maker (due to electrocution), so instead, I cut off the end of an old router power cable and attached my own connector. With this, however, I ran into another issue where the power cable was 12V, where I needed 5V for the relay and 3.3V for the ESP8266ESP-01. To fix this, I purchased a $2 boost converter from Amazon to go from 12V -> 5V, and then used a small resistor in series between 5V -> 3.3V to get all the different voltages. Reflecting, I should have just used a Wall->USB adapter (the ones that come with old phones) since that was already 5V.

For the coffee machine, I purchased the cheapest one on Amazon I could find, tore out the existing switch, and installed my relay. I also tried to make the circuit as small as possible (to make it a challenge), which was another paint point. After tripping the circuit breaker a couple of times, I eventually got it to work. Below are some pictures of the hardware I created:

<table><tr>
<td> <img src="https://scontent.fyvr3-1.fna.fbcdn.net/v/t1.15752-9/116906206_934790566985532_2052181954420371132_n.jpg?_nc_cat=109&_nc_sid=b96e70&_nc_ohc=FiEXWBivzgIAX-lwipy&_nc_ht=scontent.fyvr3-1.fna&oh=08d17db9a45e64bcc810b2a778a94cdd&oe=5F528F01" alt="Bottom of coffee machine" style="width: 250px;"/> </td>
<td> <img src="https://scontent.fyvr3-1.fna.fbcdn.net/v/t1.15752-9/116906637_733582537438841_7662706576767061270_n.jpg?_nc_cat=104&_nc_sid=b96e70&_nc_ohc=GaU38JALQuUAX-n0pZS&_nc_ht=scontent.fyvr3-1.fna&oh=5279f304a8dfa208a3f77d3b7630cb68&oe=5F525F02" alt="Power cord that I adapted" style="width: 250px;"/> </td>
<td> <img src="https://scontent.fyvr3-1.fna.fbcdn.net/v/t1.15752-9/116873200_727795954677855_4101342757163698859_n.jpg?_nc_cat=105&_nc_sid=b96e70&_nc_ohc=I3jzVFEAMgAAX8m_hp-&_nc_ht=scontent.fyvr3-1.fna&oh=aa6490099ef7f095e8cf3cb0bce7a49b&oe=5F5054D9" alt="Main circuit board" style="width: 250px;"/> </td>
<td> <img src="https://scontent.fyvr3-1.fna.fbcdn.net/v/t1.15752-9/116911357_306065067129790_3396534566888020714_n.jpg?_nc_cat=104&_nc_sid=b96e70&_nc_ohc=oWAe2DDtjcsAX9QjG5d&_nc_ht=scontent.fyvr3-1.fna&oh=b0054e62dd060f1bd207b7ab11acd92e&oe=5F51B951" alt="Wiring of the circuit board. White = Data, Black = GND, Red = 12V/5V/3.3V" style="width: 250px;"/> </td>
</tr></table>


## Firmware
The current state of the firmware for my IoT device can be found in this repository: https://github.com/TimLampen/iot_coffee_firmware. Thankfully the ESP8266ESP-01 supports being programmed in C++, so I didn't have to use Assembly. The largest problem I had was trying to connect the device to the end user's WiFi without making the user explicitly type in their SSID/Password. I see other internet-connected devices being able to do this by connecting to the user's phone / using a QR code, but I was not able to figure it out. In the end, I was able to complete the pairing process through the following steps:

1. ESP8266ESP-01 is set to access point (AP) mode.
2. The user then connects to the AP and send their WiFi details.
3. The ESP8266ESP-01 sends the user a UUID representing the specific model, turns of the AP, and connects to the Firebase database.

When the user wants to change the state of the relay connected to the ESP8266ESP-01, a simple key-value (UUID, Boolean) would be sent to the Firebase Database, where the ESP8266ESP-01 is listening for changes to its specific UUID, and would update it's state accordingly.

Features that still need to be implemented:
- Changing SSID/password settings
- Timing capability
- Greater variety of potential states (not just 0/1, but 0,1,...,99,... etc).

## UI
Definetly an area that I can improve upon, but tried to make it seem as 'light' as possible on the eyes.

<table><tr>
<td> <img src="https://scontent.fyvr3-1.fna.fbcdn.net/v/t1.15752-9/116742769_1592040800962919_662927854934488159_n.png?_nc_cat=101&_nc_sid=b96e70&_nc_ohc=XRnVrOROc7cAX-Jv3kr&_nc_ht=scontent.fyvr3-1.fna&oh=885baf81ac379fb8e1d2c9a22719b302&oe=5F4F889C" alt="App homepage" style="width: 10x;"/> </td>
<td> <img src="https://scontent.fyvr3-1.fna.fbcdn.net/v/t1.15752-9/115740803_670893356854081_5445788336574420717_n.png?_nc_cat=104&_nc_sid=b96e70&_nc_ohc=3jxHrmlPRFoAX_C8SZZ&_nc_ht=scontent.fyvr3-1.fna&oh=5db30116e3d35aabb073daf3baabf131&oe=5F508128" alt="App screen once the 'brew' button has been pressed" style="width: 10px;"/> </td>
</tr></table>

