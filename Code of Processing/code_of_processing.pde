import processing.serial.*;
Serial myPort;

class pianoSonar
{
  private String nombreArchivo;

  //funcion para cargararchivo
  public void cargarNombreArchivo(String nuevoArchivo)
  {
    this.nombreArchivo = nuevoArchivo;
  }
 
  // Método para cargar melodías
  public void cargarMelodia()
  {
    String datosArchivo[] = loadStrings(nombreArchivo);
   
    for (String lineaArchivo : datosArchivo)
    {
      // Divide la línea por comas
      String separa[] = split(lineaArchivo, ',');
     
      // Verifica si la línea tiene al menos dos elementos
      if (separa.length >= 2)
      {
        String mensaje = separa[0] + ":" + separa[1];
        separa[1] = separa[1].trim();
        int duracionNota = Integer.parseInt(separa[1]);
        println(mensaje);
        myPort.write(mensaje + "\n"); // Enviar al Arduino
        delay (duracionNota);
      }
      else
        println("Línea inválida: " + lineaArchivo);
    }
  }
}
pianoSonar sonar = new pianoSonar ();


int[] whiteKeys = {0, 2, 4, 5, 7, 9, 11, 12}; // Índices de teclas blancas
int[] blackKeys1 = {1, 3, -10, -10};                     // Índices de taclas negras
int[] blackKeys2 = {6, 8, 10, -10, -10, -10, -10, -10}; //

int lastKeyPressed = -1; // Última tecla recibida de Arduino
int octava = 4; // Octava en uso
int aux; // Auxiliar cambio de octava


void setup()
{
  size(740, 240);
  myPort = new Serial(this, "COM3", 9600);
}

void draw()
{
  background(255);
  float keyDepth = 20; // Profundidad para simular 3D
 
  fill(0);
  textSize(25);
  text("OCTAVA:   " + octava, 568, 50);
  textSize(15);
  text("(Mín: octava 2  -  Máx: octava 6)", 532, 70);
 
  boolean masPressed = mousePressed && mouseX > 567 && mouseX < 627 && mouseY > 90 && mouseY < 130; // Controla presion del boton "+"
 
  if (masPressed)
  {
    fill(180);
    noStroke(); // Quita la línea divisoria cuando está presionado
  }
  else
  {
    fill(220);
    stroke(0);  // Dibuja la línea divisoria cuando no está presionado
  }
 
  beginShape();
  vertex(567, 90);
  vertex(627, 90);
  vertex(627, 130);
  vertex(567,130);
  endShape(CLOSE);
   
  boolean menosPressed = mousePressed && mouseX > 627 && mouseX < 687 && mouseY > 90 && mouseY < 130; // Controla presion del boton "-"
 
  if (menosPressed)
  {
    fill(180);
    noStroke();
  }
  else
  {
    fill(220);
    stroke(0);
  }
   
  beginShape();
  vertex(627, 90);
  vertex(687, 90);
  vertex(687, 130);
  vertex(627, 130);
  endShape(CLOSE);
 
  fill(0);
  textSize(30);
  text("+", 650, 119);
  text("-", 592, 118);

  fill (0);
  textSize (19);
  text ("Seleccione una melodía:", 535, 180);

  boolean cargarMelodia1 = mousePressed && mouseX > 545 && mouseX < 580 && mouseY > 197 && mouseY < 230; // Controla presion del boton "1"
 
  if (cargarMelodia1)
  {
    fill(150);
    noStroke();
    sonar.cargarNombreArchivo ("Himno de la Alegria.txt");
    sonar.cargarMelodia();
  }
  else
  {
    fill(220);
    stroke(0);
  }
 
  fill (180);
  beginShape ();
  vertex (545, 197);
  vertex (580, 197);
  vertex (580, 230);
  vertex (545, 230);
  endShape(CLOSE);
 
  fill (0);
  textSize (22);
  text ("1", 557, 220);
 
  boolean cargarMelodia2 = mousePressed && mouseX > 610 && mouseX < 645 && mouseY > 197 && mouseY < 230; // Controla presion del boton "2"
 
  if (cargarMelodia2)
  {
    fill(150);
    noStroke();
    sonar.cargarNombreArchivo ("Jingle Bells.txt");
    sonar.cargarMelodia ();
  }
  else
  {
    fill(220);
    stroke(0);
  }
 
  fill (180);
  beginShape ();
  vertex (610, 197);
  vertex (645, 197);
  vertex (645, 230);
  vertex (610, 230);
  endShape(CLOSE);
 
  fill (0);
  textSize (22);
  text ("2", 622, 220);

  boolean cargarMelodia3 = mousePressed && mouseX > 675 && mouseX < 710 && mouseY > 197 && mouseY < 230; // Controla presion del boton "3"
 
  if (cargarMelodia3)
  {
    fill(150);
    noStroke();
    sonar.cargarNombreArchivo ("Feliz Cumpleaños.txt");
    sonar.cargarMelodia ();
  }
  else
  {
    fill(220);
    stroke(0);
  }
 
  fill (180);
  beginShape ();
  vertex (675, 197);
  vertex (710, 197);
  vertex (710, 230);
  vertex (675, 230);
  endShape(CLOSE);
 
  fill (0);
  textSize (22);
  text ("3", 687, 220);

  // Dibuja teclas blancas con efecto 3D
  for (int i = 0; i < whiteKeys.length; i++)
  {
    int x = i * 65;
    boolean isPressed = mousePressed && mouseX > x && mouseX < x + 65 && mouseY < 220 && !isOverBlackKey() || (lastKeyPressed == whiteKeys[i]); // Controla presion de teclas blancas

    if (isPressed)
    {
      fill(200); // Color de presionado para tecla blanca
      noStroke(); 
      mousePressed();
    }
    else
    {
      fill(255);
      stroke(0);
    }

    rect(x, 0, 65, 200); // Tecla blanca

    // Borde inferior para simular 3D
    if (isPressed)
    {
      fill(180); // Color de borde más oscuro cuando la tecla está presionada
    }
    else
    {
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
    boolean isPressed = mousePressed && mouseX > x && mouseX < x + 40 && mouseY < 140 || (lastKeyPressed == blackKeys1[i-1]); // Controla presion de teclas negras

    if (isPressed)
    {
      fill(100); // Color de presionado para tecla negra
      noStroke(); // Quita la línea divisoria cuando está presionado
      mousePressed();
    }
    else
    {
      fill(0);
      stroke(0); // Dibuja la línea divisoria cuando no está presionado
    }

    rect(x, 0, 40, 120); // Tecla negra

    // Borde inferior para simular 3D en tecla negra
    if (isPressed)
    {
      fill(80); // Color de borde más oscuro cuando la tecla está presionada
    }
    else
    {
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
      mousePressed();
    }
    else
    {
      fill(0);
      stroke(0); // Dibuja la línea divisoria cuando no está presionado
    }

    rect(x, 0, 40, 120); // Tecla negra

    // Borde inferior para simular 3D en tecla negra
    if (isPressed)
    {
      fill(80); // Color de borde más oscuro cuando la tecla está presionada
    }
    else
    {
      fill(50); // Color de borde normal
    }
   
    beginShape();
    vertex(x, 120);
    vertex(x + 40, 120);
    vertex(x + 40, 120 + keyDepth);
    vertex(x, 120 + keyDepth);
    endShape(CLOSE);
  }
 
  lastKeyPressed = -1;
}


// Función auxiliar para evitar que se presionen una tecla blanca y una negra a la vez
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


void serialEvent(Serial myPort)
{
  // Leer tecla desde Arduino
  String key = myPort.readStringUntil('\n');
  if (key != null)
  {
    aux = int(trim(key));
    if (aux > -1 && aux < 13)
    {
      println (lastKeyPressed);
      lastKeyPressed = int(trim(key)); // Guardar índice de tecla
    }
    cambioOctava(aux);
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

    // Verificar teclas negras
    if (x > xNegras && x < xNegras + 40 && y < yNegras)
    {
      println (i + "N");
      return i + "N";
    }

    // Verificar teclas blancas
    if (x > xBlancas && x < xBlancas + 65 && y < yBlancas && !isOverBlackKey())
    {
      println (i + "B");
      return i + "B";
    }
   
    if (x > 567 && x < 627 && y > 90 && y < 130)
    {
      aux = -2;
      cambioOctava(aux);
      return "-2";
    }
   
    if (x > 627 && x < 687 && y > 90 && y < 130)
    {
      aux = -3;
      cambioOctava(aux);
      return "-3";
    }
  }

  // Si no se presionó ninguna tecla, devolver "-1"
  return "-1";
}


void cambioOctava(int aux) // Verificar que la octava este dentro de los parametros, de ser asi, realizar el cambio
{
  if (aux == -2)
    {
      octava --;
      if (octava < 2)
      {
        octava = 2;
      }
    }
 
    if (aux == -3)
    {
      octava ++;
      if (octava > 6)
      {
        octava = 6;
      }
    }
}
