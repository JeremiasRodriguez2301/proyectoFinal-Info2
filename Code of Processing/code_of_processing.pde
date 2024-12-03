import processing.serial.*;

Serial myPort;
int lastKeyPressed = -1; // Última tecla recibida de Arduino

int[] whiteKeys = {0, 2, 4, 5, 7, 9, 11, 12}; // Índices de teclas blancas
//int[] blackKeys = {1, 3, 6, 8, 10};
int[] blackKeys1 = {1, 3, -2, -2};
int[] blackKeys2 = {6, 8, 10, -2, -2, -2, -2, -2};

int contadorBlancas = -1;
int contadorNegras = 0;

class Nota
{
  
  String nombreNota;
  int duracionNota;
  
    Nota(String nombreNota, int duracionNota) 
    {
      this.nombreNota = nombreNota;
      this.duracionNota = duracionNota;
    }
    
}

ArrayList<Nota> notas = new ArrayList<Nota>(); //Crea una lista para los objetos "Nota" creados

void setup()
{
  String puertoDisponible [] = Serial.list();
  size(520, 250);
  myPort = new Serial(this, puertoDisponible [0], 9600);
  
  String datosArchivo [] = loadStrings ("notas.txt");
  
  for (String lineaArchivo : datosArchivo) 
  {
    String separa [] = split(lineaArchivo, ',');
    String mensaje = separa [0] + ":" + separa [1];
    println (mensaje);
    
    String nombreNota = separa [0];
    int duracionNota = int (separa [1].trim());
    
    notas.add (new Nota (nombreNota, duracionNota));
    
    //myPort.write(mensaje);  // Enviar al Arduino
    delay(100);
  }
  
  //Verificar que las notas se loading correctamente
  
   for (Nota nota : notas)
     println("Nota: " + nota.nombreNota + ", Duración: " + nota.duracionNota);
     
   enviarDatosArchivo ();  
  
}

void draw()
{
  background(255);
  float keyDepth = 20; // Profundidad para simular 3D

  // Dibuja teclas blancas con efecto 3D
  for (int i = 0; i < whiteKeys.length; i++)
  {
    int x = i * 65;
    boolean isPressed = mousePressed && mouseX > x && mouseX < x + 65 && mouseY < 220 && !isOverBlackKey() || (lastKeyPressed == whiteKeys[i]);

    if (isPressed)
    {
      fill(200); // Color de presionado para tecla blanca
      noStroke(); // Quita la línea divisoria cuando está presionado
    }
    else
    {
      fill(255);
      stroke(0); // Dibuja la línea divisoria cuando no está presionado
    }

    rect(x, 0, 65, 200); // Tecla blanca

    // Borde inferior para simular 3D
    if (isPressed) {
      fill(180); // Color de borde más oscuro cuando la tecla está presionada
    } else {
      fill(220); // Color de borde normal
    }
    beginShape();
    vertex(x, 200);
    vertex(x + 65, 200);
    vertex(x + 65, 200 + keyDepth);
    vertex(x, 200 + keyDepth);
    endShape(CLOSE);
  }

  // Dibuja teclas negras con efecto 3D
  for (int i = 1; i < 3; i++)
  {
    int x = i * 65 - 20;
    boolean isPressed = mousePressed && mouseX > x && mouseX < x + 40 && mouseY < 140 || (lastKeyPressed == blackKeys1[i-1]);

    if (isPressed)
    {
      fill(100); // Color de presionado para tecla negra
      noStroke(); // Quita la línea divisoria cuando está presionado
    }
    else
    {
      fill(0);
      stroke(0); // Dibuja la línea divisoria cuando no está presionado
    }

    rect(x, 0, 40, 120); // Tecla negra

    // Borde inferior para simular 3D en tecla negra
    if (isPressed) {
      fill(80); // Color de borde más oscuro cuando la tecla está presionada
    } else {
      fill(50); // Color de borde normal
    }
    beginShape();
    vertex(x, 120);
    vertex(x + 40, 120);
    vertex(x + 40, 120 + keyDepth);
    vertex(x, 120 + keyDepth);
    endShape(CLOSE);
  }
 
  for (int i = 4; i < 7; i++)
  {
    int x = i * 65 - 20;
    boolean isPressed = mousePressed && mouseX > x && mouseX < x + 40 && mouseY < 140 || (lastKeyPressed == blackKeys2[i-4]);

    if (isPressed)
    {
      fill(100); // Color de presionado para tecla negra
      noStroke(); // Quita la línea divisoria cuando está presionado
    }
    else
    {
      fill(0);
      stroke(0); // Dibuja la línea divisoria cuando no está presionado
    }

    rect(x, 0, 40, 120); // Tecla negra

    // Borde inferior para simular 3D en tecla negra
    if (isPressed) {
      fill(80); // Color de borde más oscuro cuando la tecla está presionada
    } else {
      fill(50); // Color de borde normal
    }
    beginShape();
    vertex(x, 120);
    vertex(x + 40, 120);
    vertex(x + 40, 120 + keyDepth);
    vertex(x, 120 + keyDepth);
    endShape(CLOSE);
  }
}

// Función auxiliar para verificar si el mouse está sobre una tecla negra
boolean isOverBlackKey()
{
  for (int i = 1; i < 3; i++)
  {
    int x = i * 65 - 20;
    if (mouseX > x && mouseX < x + 40 && mouseY < 140)
    {
      return true;
    }
  }
  for (int i = 4; i < 7; i++)
  {
    int x = i * 65 - 20;
    if (mouseX > x && mouseX < x + 40 && mouseY < 140)
    {
      return true;
    }
  }
  return false;
}

void mousePressed()
{
  // Determinar qué tecla se presiona en Processing
  String keyIndex = "";
   
  keyIndex = getKeyIndex(mouseX, mouseY);
  if (keyIndex != "-1")
  {
    myPort.write(keyIndex + "\n"); // Enviar índice a Arduino
  }
}

void serialEvent(Serial myPort) {
  // Leer tecla desde Arduino
  String key = myPort.readStringUntil('\n');
  if (key != null) {
    lastKeyPressed = int(trim(key)); // Guardar índice de tecla
    //println (lastKeyPressed);
  }
}

String getKeyIndex(int x, int y)
{
  for (int i = 0; i < 13; i++)
  {
    int xBlancas = i * 65;
    int yBlancas = 220;
    int xNegras = xBlancas - 20;
    int yNegras = 140;

    // Verificar teclas negras primero (prioridad sobre blancas)
    if (x > xNegras && x < xNegras + 40 && y < yNegras) {
      println("Mouse X negras:", x);
      println("Mouse Y negras:", y);
      println("El valor i presionado (negra) es:", i, "N");
     
      println (i + "N");
      return i + "N"; // Retornar inmediatamente
    }



    // Verificar teclas blancas
    if (x > xBlancas && x < xBlancas + 65 && y < yBlancas && y > yNegras  ) {
      println("Mouse X blancas:", x);
      println("Mouse Y blancas:", y);
      println("El valor i presionado (blanca) es:", i, "B");
     
      println (i + "B");
      return i + "B"; // Retornar inmediatamente
    }
  }

  // Si no se presionó ninguna tecla, devolver "-1"
  return "-1";
}

void enviarDatosArchivo ()
{
   for (Nota nota : notas) 
   {
    // Formatea el dato como "nombre:duracion\n"
    String dato = nota.nombreNota + ":" + nota.duracionNota + "\n";
    println (dato);
   // myPort.write(dato);  // Envía la cadena al Arduino
    println("Enviado: " + dato);
  }
}
