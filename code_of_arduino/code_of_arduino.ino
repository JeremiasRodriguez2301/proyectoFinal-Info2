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

int *notas, *notasTemp;

void setup() 
{
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
      Serial.println(-3);
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
      Serial.println(-2);
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
    /*else
    {
      Serial.println(-1);
    }*/
  }

  // Recibir datos de Processing

  if (Serial.available() > 0)
  {
    String tecla = Serial.readStringUntil('\n');
    tecla.trim();  // Eliminar espacios al inicio y final
    procesarEntrada(tecla);  // Procesar la entrada
  }

}

// Función para procesar la entrada desde el puerto serie
void procesarEntrada(String entrada) 
{
  if (entrada.indexOf(':') != -1) 
    procesarNotaYDuracion(entrada); // Caso: tiene el carácter ":"
  
  else
  procesarComandoSimple(entrada);// Caso: no tiene ":"
  
}

// Función para procesar notas con duración (contiene ":")
void procesarNotaYDuracion(String entrada) 
{
  int separador = entrada.indexOf(':');
  String nota = entrada.substring(0, separador);  // Extraer nota
  String duracionStr = entrada.substring(separador + 1);  // Extraer duración
  duracionStr.trim();  // Eliminar espacios adicionales

  int duracion = duracionStr.toInt();  // Convertir duración a entero
  
  // Ejecutar acción en base a la nota
  if (nota == "Do")
    tone(buzzer, octava[0], duracion);  // DO
  
  else if (nota == "DoS")
    tone(buzzer, octava[1], duracion);  // DO#
  
  else if (nota == "Re")
    tone(buzzer, octava[2], duracion);  // RE

  else if (nota == "ReS")
    tone(buzzer, octava[3], duracion);  // RE#

  else if (nota == "Mi")
    tone(buzzer, octava[4], duracion);  // MI

  else if (nota == "Fa")
    tone(buzzer, octava[5], duracion);  // fa

  else if (nota == "FaS")
    tone(buzzer, octava[6], duracion);  // fa#

  else if (nota == "Sol")
    tone(buzzer, octava[7], duracion);  // Sol

  else if (nota == "SolS")
    tone(buzzer, octava[8], duracion);  // sol#

  else if (nota == "La")
    tone(buzzer, octava[9], duracion);  // La

  else if (nota == "LaS")
    tone(buzzer, octava[10], duracion);  // La#

  else if (nota == "Si")
    tone(buzzer, octava[11], duracion);  // Si

  else if (nota == "Do2")
    tone(buzzer, octava[12], duracion);  // MI

  else if (nota == "Silencio")
    delay(duracion);

  entrada ="";

}

// Función para procesar comandos simples
void procesarComandoSimple(String comando) 
{
  if (comando == "grabarMelodia")
  {
    Serial.println ("grabandoMelodia");
      
    for (int i = 0; i < 13; i++)
    {
      //if ()

      if (digitalRead(pinNotas[i]) == LOW)
      {
        tone(buzzer, octava[i], 100);
        Serial.print ("indice_Grabar, ");
        Serial.println (i);
      }  

    }
  }

  else if (comando == "finalizarMelodia")
  {
    Serial.println ("grabacionFinalizada");
  }


  if (comando == "0B")
    tone(buzzer, octava[0], 100); //DO
  
  if (comando == "1N")
    tone(buzzer, octava[1], 100); //DO#

  if (comando == "1B")
    tone(buzzer, octava[2], 100); //RE

  if (comando == "2N")
    tone(buzzer, octava[3], 100); //RE#

  if (comando == "2B")
    tone(buzzer, octava[4], 100); //MI

  if (comando == "3B")
    tone(buzzer, octava[5], 100); //FA

  if (comando == "4N")
    tone(buzzer, octava[6], 100); //FA#

  if (comando == "4B")
    tone(buzzer, octava[7], 100); //SOL

  if (comando == "5N")
    tone(buzzer, octava[8], 100); //SOL#

  if (comando == "5B")
    tone(buzzer, octava[9], 100); //LA

  if (comando == "6N")
    tone(buzzer, octava[10], 100); //LA#

  if (comando == "6B")
    tone(buzzer, octava[11], 100); //SI

  if (comando == "7B")
    tone(buzzer, octava[12], 100); //DO

  if (comando == "-2")
    octActual--;
    if (octActual < 2)
    {
      octActual = 2;
    }
    cambioOctava(octActual);
  
  if (comando == "-3")
    octActual++;
    if (octActual > 6) 
    {
      octActual = 6;
    }
    cambioOctava(octActual);

    comando = "";

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