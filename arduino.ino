#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include "HX711.h"
#include <LiquidCrystal_I2C.h>
#include <SPI.h>
#include <MFRC522.h>

#define DOUT  D0
#define CLK   D8
#define SS    D4
#define RST   D3

#define WIFI_SSID "*************"
#define WIFI_PASSWORD "*******"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             "
#define FIREBASE_HOST "nodemcu-ac498-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "rcp3WJs0ArgiIZTOPt4GLOU1pKnAIOr88BY1H4g2"
#define DEVICE_ID "6G34"
#define CARD 1

MFRC522 rfid(SS, RST);
MFRC522::MIFARE_Key key;

HX711 scale(DOUT, CLK);
LiquidCrystal_I2C lcd (0x27, 16, 2);

FirebaseData fbdo;
FirebaseJson json;

String HOME_DIR = DEVICE_ID;
String ID_DIR = HOME_DIR + "/ID";
String WEIGHT_DIR = HOME_DIR + "/WEIGHT";
String IN_USE_DIR = HOME_DIR + "/IN_USE";
String SESSION_TYPE_DIR = HOME_DIR + "/SESSION_TYPE";
String SESSION_ID_DIR = HOME_DIR + "/SESSION_ID";

float weight = 0.0;
float saved_weight = 0.0;
float old_weight = 0.0;
bool in_use = 0;
byte session_type = 0; //0: NONE          1: CARD             2: QR
String session_id = "NONE";

byte cardID[4];
float calibration_factor = -2050000.00;
unsigned long START_TIME = 0;

void printResult(FirebaseData &data);

void setup() {
  Serial.begin(115200);
  lcd.begin();
  SPI.begin();
  rfid.PCD_Init();
  pinMode(LED_BUILTIN, OUTPUT);

  for (byte i = 0; i < 6; i++) {
    key.keyByte[i] = 0xFF;
  }

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print('.');
    delay(300);
  }
  Serial.print("\nConnected with IP: ");
  Serial.println(WiFi.localIP());

  scale.tare();

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  fbdo.setBSSLBufferSize(1024, 1024);
  fbdo.setResponseSize(1024);
  Firebase.setReadTimeout(fbdo, 1000 * 60);
  Firebase.setwriteSizeLimit(fbdo, "tiny");
  Firebase.setFloatDigits(4);

  Serial.print("HOME:");
  Serial.println(HOME_DIR);
  Serial.print("ID:");
  Serial.println(ID_DIR);
  Serial.print("IN_USE:");
  Serial.println(IN_USE_DIR);
  Serial.print("WEIGHT:");
  Serial.println(WEIGHT_DIR);
  Serial.print("SESSION_TYPE:");
  Serial.println(SESSION_TYPE_DIR);
  Serial.print("SESSION_ID:");
  Serial.println(SESSION_ID_DIR);

  setID(DEVICE_ID);
  setInUse(0);
  setWeight(0);
  setSessionType(0);
  setSessionID("NULL");

  scale.set_scale(calibration_factor);

  weight = scale.get_units();
  old_weight = weight;
  if (weight < 0) weight = weight * -1;
  setWeight(weight);
  printWeight(weight);

  START_TIME = millis();
}

void loop() {
  weight = scale.get_units();
  if (weight < 0) weight = weight * -1;
  printWeight(weight);

  if (rfid.PICC_IsNewCardPresent()) {
    if (rfid.PICC_ReadCardSerial()) {
      session_id = "";
      for (byte i = 0; i < 4; i++) {
        cardID[i] = rfid.uid.uidByte[i];
        if (i != 3) session_id = session_id + String(rfid.uid.uidByte[i], HEX) + ':';
        else session_id = session_id + String(rfid.uid.uidByte[i], HEX);
      }
      Serial.println(session_id);
      setSessionID(session_id);
      setSessionType(1);
      lcd.setCursor(15, 0);
      lcd.print("a");
      START_TIME = millis();

      while (millis() - START_TIME < 5000) {
        weight = scale.get_units();
        if (weight < 0) weight = weight * -1;
        setWeight(weight);
        printWeight(weight);
      }

      saved_weight = weight;
      setPoint(session_id, weight - old_weight);
      old_weight = weight;

      setSessionID("NULL");
      setSessionType(0);

      lcd.clear();
      rfid.PICC_HaltA();
      rfid.PCD_StopCrypto1();
    }
  }
  Firebase.getInt(fbdo, SESSION_TYPE_DIR);
  session_type = fbdo.intData();

  if (session_type == 2) {
    Firebase.getInt(fbdo, SESSION_ID_DIR);
    setInUse(1);
    session_id = fbdo.stringData();

    lcd.setCursor(15, 0);
    lcd.print("a");
    START_TIME = millis();

    while (millis() - START_TIME < 5000) {
      weight = scale.get_units();
      if (weight < 0) weight = weight * -1;
      setWeight(weight);
      printWeight(weight);
    }
    saved_weight = weight;
    setPoint(session_id, weight - old_weight);
    old_weight = weight;
    setSessionID("NULL");
    setSessionType(0);
    setInUse(0);
  }
}

bool setPoint(String sid, float w) {
  if (Firebase.setFloat(fbdo, ('/' + sid), w)) {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("ETag: " + fbdo.ETag());
    Serial.print("VALUE: ");
    printResult(fbdo);
    Serial.println("------------------------------------");
    Serial.println();
    return 1;
  }
  else {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
    return 0;
  }
}

void printWeight(float weight) {
  lcd.home();
  lcd.print("Weight:");
  lcd.setCursor(0, 1);
  lcd.print(weight, 4);
  lcd.print(" mg");
}

bool setID(String i) {
  if (Firebase.setString(fbdo, ID_DIR, i)) {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("ETag: " + fbdo.ETag());
    Serial.print("VALUE: ");
    printResult(fbdo);
    Serial.println("------------------------------------");
    Serial.println();
    return 1;
  }
  else {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
    return 0;
  }
}

bool setWeight(float w) {
  if (Firebase.setFloat(fbdo, WEIGHT_DIR, w)) {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("ETag: " + fbdo.ETag());
    Serial.print("VALUE: ");
    printResult(fbdo);
    Serial.println("------------------------------------");
    Serial.println();
    return 1;
  }
  else {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
    return 0;
  }
}

bool setInUse(bool i) {
  if (Firebase.setBool(fbdo, IN_USE_DIR, i)) {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("ETag: " + fbdo.ETag());
    Serial.print("VALUE: ");
    printResult(fbdo);
    Serial.println("------------------------------------");
    Serial.println();
    return 1;
  }
  else {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
    return 0;
  }
}

bool setSessionType(byte st) {
  if (Firebase.setInt(fbdo, SESSION_TYPE_DIR, st)) {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("ETag: " + fbdo.ETag());
    Serial.print("VALUE: ");
    printResult(fbdo);
    Serial.println("------------------------------------");
    Serial.println();
    return 1;
  }
  else {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
    return 0;
  }
}

bool setSessionID(String si) {
  if (Firebase.setString(fbdo, SESSION_ID_DIR, si)) {
    Serial.println("PASSED");
    Serial.println("PATH: " + fbdo.dataPath());
    Serial.println("TYPE: " + fbdo.dataType());
    Serial.println("ETag: " + fbdo.ETag());
    Serial.print("VALUE: ");
    printResult(fbdo);
    Serial.println("------------------------------------");
    Serial.println();
    return 1;
  }
  else {
    Serial.println("FAILED");
    Serial.println("REASON: " + fbdo.errorReason());
    Serial.println("------------------------------------");
    Serial.println();
    return 0;
  }
}

void printResult(FirebaseData & data) {
  if (data.dataType() == "int")
    Serial.println(data.intData());
  else if (data.dataType() == "float")
    Serial.println(data.floatData(), 5);
  else if (data.dataType() == "double")
    printf("%.9lf\n", data.doubleData());
  else if (data.dataType() == "boolean")
    Serial.println(data.boolData() == 1 ? "true" : "false");
  else if (data.dataType() == "string")
    Serial.println(data.stringData());
  else if (data.dataType() == "json")
  {
    Serial.println();
    FirebaseJson &json = data.jsonObject();
    Serial.println("Pretty printed JSON data:");
    String jsonStr;
    json.toString(jsonStr, true);
    Serial.println(jsonStr);
    Serial.println();
    Serial.println("Iterate JSON data:");
    Serial.println();
    size_t len = json.iteratorBegin();
    String key, value = "";
    int type = 0;
    for (size_t i = 0; i < len; i++)
    {
      json.iteratorGet(i, type, key, value);
      Serial.print(i);
      Serial.print(", ");
      Serial.print("Type: ");
      Serial.print(type == FirebaseJson::JSON_OBJECT ? "object" : "array");
      if (type == FirebaseJson::JSON_OBJECT)
      {
        Serial.print(", Key: ");
        Serial.print(key);
      }
      Serial.print(", Value: ");
      Serial.println(value);
    }
    json.iteratorEnd();
  }
  else if (data.dataType() == "array")
  {
    Serial.println();
    FirebaseJsonArray &arr = data.jsonArray();
    Serial.println("Pretty printed Array:");
    String arrStr;
    arr.toString(arrStr, true);
    Serial.println(arrStr);
    Serial.println();
    Serial.println("Iterate array values:");
    Serial.println();
    for (size_t i = 0; i < arr.size(); i++)
    {
      Serial.print(i);
      Serial.print(", Value: ");

      FirebaseJsonData &jsonData = data.jsonData();
      arr.get(jsonData, i);
      if (jsonData.typeNum == FirebaseJson::JSON_BOOL)
        Serial.println(jsonData.boolValue ? "true" : "false");
      else if (jsonData.typeNum == FirebaseJson::JSON_INT)
        Serial.println(jsonData.intValue);
      else if (jsonData.typeNum == FirebaseJson::JSON_FLOAT)
        Serial.println(jsonData.floatValue);
      else if (jsonData.typeNum == FirebaseJson::JSON_DOUBLE)
        printf("%.9lf\n", jsonData.doubleValue);
      else if (jsonData.typeNum == FirebaseJson::JSON_STRING ||
               jsonData.typeNum == FirebaseJson::JSON_NULL ||
               jsonData.typeNum == FirebaseJson::JSON_OBJECT ||
               jsonData.typeNum == FirebaseJson::JSON_ARRAY)
        Serial.println(jsonData.stringValue);
    }
  }
  else if (data.dataType() == "blob")
  {

    Serial.println();

    for (int i = 0; i < data.blobData().size(); i++)
    {
      if (i > 0 && i % 16 == 0)
        Serial.println();

      if (i < 16)
        Serial.print("0");

      Serial.print(data.blobData()[i], HEX);
      Serial.print(" ");
    }
    Serial.println();
  }
  else if (data.dataType() == "file")
  {

    Serial.println();

    File file = data.fileStream();
    int i = 0;

    while (file.available())
    {
      if (i > 0 && i % 16 == 0)
        Serial.println();

      int v = file.read();

      if (v < 16)
        Serial.print("0");

      Serial.print(v, HEX);
      Serial.print(" ");
      i++;
    }
    Serial.println();
    file.close();
  }
  else
  {
    Serial.println(data.payload());
  }
}
