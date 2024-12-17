void setup() {
  Serial.begin(115200);
}

void loop() {
  long horaInicial = millis();
  long soma = 0;
  int leituras = 0;
  while ((millis() - horaInicial) < 20) {
    soma += analogRead(A0);
    leituras++;
  }
  Serial.print("{\"emg\":");
  Serial.print(soma / leituras);
  Serial.print("}");
  delay(250);
}
