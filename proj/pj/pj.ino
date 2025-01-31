#include <DHT.h>
#include <LiquidCrystal.h>

#define DHTPIN 2
#define DHTTYPE DHT11
#define LED 13
#define SWITCH 4

unsigned long previousMillis = 0;
unsigned long alarmMillis = 0;
const long interval = 1000;
const long alarmInterval = 4000;
bool state = true;
DHT dht(DHTPIN, DHTTYPE);
LiquidCrystal lcd(7, 8, 9, 10, 11, 12);

void setup() {
    lcd.begin(16, 2);
    pinMode(LED, OUTPUT);
    pinMode(SWITCH, INPUT);
    dht.begin();
    Serial.begin(9600);
}

void loop() {
    int status = digitalRead(SWITCH);
    float humidity = dht.readHumidity();
    float temperature = dht.readTemperature();
    Serial.print(temperature);
    Serial.print(",");
    Serial.println(humidity);
    int error = 0;

    float temperature_prediction = 0.00;
    float humidity_prediction = 0.00;
    if (Serial.available() > 0) {
            String received = Serial.readStringUntil('\n');
            int firstComma = received.indexOf(',');
            int secondComma = received.indexOf(',', firstComma + 1);

            if (firstComma != -1 && secondComma != -1) {
                temperature_prediction = received.substring(0, firstComma).toFloat();
                humidity_prediction = received.substring(firstComma + 1, secondComma).toFloat();
                error = received.substring(secondComma + 1).toInt();
            }
    }
        
    if (status == HIGH) {
        humidity = humidity_prediction;
        temperature = temperature_prediction;
    }

    unsigned long currentMillis = millis();

    if (currentMillis - previousMillis >= interval) {
        previousMillis = currentMillis;
        lcd.clear();
        if (state) {
            lcd.setCursor(0, 0);
            lcd.print("Temp: ");
            lcd.print(temperature);
            lcd.print("C");
        } else {
            lcd.setCursor(0, 0);
            lcd.print("Humidity: ");
            lcd.print(humidity);
            lcd.print("%");
        }
        state = !state;
    }

    if (currentMillis - alarmMillis >= alarmInterval) {
        alarmMillis = currentMillis;
        if (error) {
            lcd.setCursor(0, 1);
            lcd.print("ALARM!      ");
        } else {
            lcd.setCursor(0, 1);
            lcd.print("            ");
        }
    }

    if (error) {
        digitalWrite(LED, HIGH);
    } else {
        digitalWrite(LED, LOW);
    }

    delay(500);
}
