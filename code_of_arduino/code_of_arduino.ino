/*SEMI PROTOCOLO DE COMUNICACIÓN ARDUINO - PROCESSING
EN EL CÓDIGO DE PROCESSING, CUANDO TOCO UNA TECLA EN PROCESSING SE VA ENVIAR UN INDICE Y UN CARACTER
POR EJEMPLO, TOCAMOS DO1 -> EL CODIGO VA ENVIAR UN 0B 
0B HACE REFERENCIA A LA BLANCA NUMERO UNO 
0 -> 1
B -> BLANCA

LO MISMO OCURRE CON LA TECLA NEGRA, TENIENDO ASI LO SIGUIENTE:
OB -> DO      1N -> DO#

1B -> RE      2N -> RE#

2B -> MI      3B -> FA

4N -> FA#     4B -> SOL

5N -> SOL#    5B -> LA

6N -> LA#     6B -> SI

7B -> DO

DE ESTE MODO, SE IDENTIFICAN LAS TECLAS ENVIADAS DESDE PROCESSING*/


#define buzzer A0
#define octavaMas A1
#define octavaMenos A2

const int pinNotas[] = {22, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
int octava[13];
int octActual = 4;
unsigned long lastPress = 0;

int frecuencias2[] = {65, 69, 73, 78, 82, 87, 92, 98, 104, 110, 116, 123, 131};
int frecuencias3[] = {131, 138, 147, 155, 165, 175, 185, 196, 208, 220, 233, 246, 262};
int frecuencias4[] = {262, 277, 293, 311, 329, 349, 370, 392, 415, 440, 466, 494, 523};
int frecuencias5[] = {523, 554, 587, 622, 659, 698, 740, 784, 830, 880, 932, 987, 1046};
int frecuencias6[] = {1046, 1109, 1175, 1244, 1318, 1397, 1480, 1568, 1661, 1760, 1865, 1975, 2093};

void setup() {
  Serial.begin(9600);
  for (int i = 0; i < 13; i++)
  {
    pinMode(pinNotas[i], INPUT_PULLUP);
  }
  pinMode(buzzer, OUTPUT);
  pinMode(octavaMas, INPUT_PULLUP);
  pinMode(octavaMenos, INPUT_PULLUP);
  cambioOctava(octActual);
}

void loop()
{
  if (millis() - lastPress > 200) 
  {
    if (digitalRead(octavaMas) == LOW) 
    {
      octActual++;
      if (octActual > 6) 
      {
        octActual = 6;
      }
      cambioOctava(octActual);
      lastPress = millis();
    }
    if (digitalRead(octavaMenos) == LOW)
    {
      octActual--;
      if (octActual < 2)
      {
        octActual = 2;
      }
      cambioOctava(octActual);
      lastPress = millis();
    }
  }

  // Detectar teclas presionadas
  for (int i = 0; i < 13; i++)
  {
    if (digitalRead(pinNotas[i]) == LOW)
    {
      tone(buzzer, octava[i], 100);
      Serial.println(i); // Enviar índice de tecla a Processing
    }
  }

  // Recibir datos de Processing
  if (Serial.available() > 0)
  {
    String tecla = Serial.readStringUntil('\n');

    if (tecla == "0B")
      tone(buzzer, octava[0], 100); //DO
    
    if (tecla == "1N")
      tone(buzzer, octava[1], 100); //DO#

    if (tecla == "1B")
      tone(buzzer, octava[2], 100); //RE

    if (tecla == "2N")
      tone(buzzer, octava[3], 100); //RE#

    if (tecla == "2B")
      tone(buzzer, octava[4], 100); //MI

    if (tecla == "3B")
      tone(buzzer, octava[5], 100); //FA

    if (tecla == "4N")
      tone(buzzer, octava[6], 100); //FA#

    if (tecla == "4B")
      tone(buzzer, octava[7], 100); //SOL

    if (tecla == "5N")
      tone(buzzer, octava[8], 100); //SOL#

    if (tecla == "5B")
      tone(buzzer, octava[9], 100); //LA

    if (tecla == "6N")
      tone(buzzer, octava[10], 100); //LA#

    if (tecla == "6B")
      tone(buzzer, octava[11], 100); //SI

    if (tecla == "7B")
      tone(buzzer, octava[12], 100); //DO

      tecla = "";
  }
}

void cambioOctava(int octActual)
{
  const int* frecuencias;
  switch (octActual)
  {
    case 2:
      frecuencias = frecuencias2;
      break;
    case 3:
      frecuencias = frecuencias3;
      break;
    case 4:
      frecuencias = frecuencias4;
      break;
    case 5:
      frecuencias = frecuencias5;
      break;
    case 6:
      frecuencias = frecuencias6; 
      break;
  }
  for (int j = 0; j < 13; j++)
  {
    octava[j] = frecuencias[j];
  }
}

void tocarDesdeArchivo()
{
 if (Serial.available() > 0) 
 {
    String entrada = Serial.readStringUntil('\n');  // Leer línea completa
    entrada.trim();  // Elimina espacios en blanco al inicio y al final

    // Separar la nota y la duración
    int separador = entrada.indexOf(':');  // Encontrar el separador ":"
    
    if (separador != -1) 
    {  // Verifica que el separador exista
      String nota = entrada.substring(0, separador);  // Obtén la nota
      String duracionStr = entrada.substring(separador + 1);  // Obtén la duración
      
      duracionStr.trim();  // Elimina espacios en blanco en la duración
      int duracion = duracionStr.toInt();  // Convierte la duración a entero

      // Imprime los resultados
      println("Nota: " + nota + ", Duración: " + String(duracion));
      
      if (nota == "Do")
      tone(buzzer, octava[0], duracion); //DO
    
      if (nota == "Do#")
        tone(buzzer, octava[1], duracion); //DO#

      if (nota == "Re")
        tone(buzzer, octava[2], duracion); //RE

      if (nota == "Re#")
        tone(buzzer, octava[3], duracion); //RE#

      if (nota == "Mi")
        tone(buzzer, octava[4], duracion); //MI

      if (nota == "Fa")
        tone(buzzer, octava[5], duracion); //FA

      if (nota == "Fa#")
        tone(buzzer, octava[6], duracion); //FA#

      if (nota == "Sol")
        tone(buzzer, octava[7], duracion); //SOL 

      if (nota == "Sol#")
        tone(buzzer, octava[8], duracion); //SOL#

      if (nota == "La")
        tone(buzzer, octava[9], duracion); //LA

      if (nota == "La#")
        tone(buzzer, octava[10], duracion); //LA#

      if (nota == "Si")
        tone(buzzer, octava[11], duracion); //SI

      if (nota == "DoA")
        tone(buzzer, octava[12], duracion); //DO

    } 
    
    else 
      println("Error: Formato incorrecto. Debe ser 'Nota:Duración'");
    

  }
}