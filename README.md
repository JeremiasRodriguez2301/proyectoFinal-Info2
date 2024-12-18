# Proyecto Final Informática 2
## Funcionalidades:
El proyecto final trata sobre un minipiano simulado con Arduino y Processing. Se puede tocar a través de los botones físicos que simulan las teclas de un piano, como en el piano propuesto por Processing.
Además se pueden cargar melodías propias en el código de Processing gracias a la clase pianoSonar.

## Formato de la función melodía
Sí usted desea cargar la melodía nueva, se encontrará algo como "Feliz cumpleaños.txt", "Jingle Bells.txt", etc.
Pues el formato que hemos dispuesto es el de un archivo de texto, el mismo tiene la siguiente forma que usted debe seguir:

Nota, Duración
Silencio, Duración (opcional)

Nótese el uso de una coma (,) que separa junto al espacio después de la coma a la duración de la misma. Luego haber cumplido la consigna deberá clickear "Enter" que en el código se verá como:
Nota, Duración\n
Silencio, Duración\n

### Aclaración
El termino "\n" se agrega cuando usted presiona "Enter".
Así usted podrá cargar una melodía personalizada.
Una vez termine, observe que en la carpeta donde se encuentra Processing existe una carpeta llamada "data". Pues es de vital importancia, ya qué si su archivo .txt o cualquier tipo de archivo que no se encuentre en dicha carpeta, Processing no podrá acceder y probablemente tenga algún conflicto.
## ¿Y ahora? ¿Cómo agrego mis melodías sí ya tengo el archivo txt modelado?
Para que usted pueda cargar el archivo, deberá ir a Processing precisamente las líneas:

123 sonar.cargarNombreArchivo ("Himno de la Alegria.txt");
150 sonar.cargarNombreArchivo ("Jingle Bells.txt");
177 sonar.cargarNombreArchivo ("Feliz Cumpleaños.txt");

Usted únicamente deberá cambiar el nombre del archivo y a su vez deberá guardar su archivo en la carpeta "data" mencionada anteriormente.
Por ejemplo, solo quiero cambiar la 3 melodía, pues usted deberá cambiar el nombre del archivo incluyendo los (" ") y el agregado (.txt)
sonar.cargarNombreArchivo ("nombreEjemplo.txt");

## Recordatorio
Sí usted no tiene el archivo "nombreEjemplo.txt" en la carpeta "data" que se encuentra dentro de la carpeta donde está alojado el código de Processing, tendrá el siguiente error: nullPointerException
Esto quiere decir que Processing no encontro el archivo "nombreEjemplo.txt"

# Agradecimientos
Gracias por su tiempo, buena suerte!

# Final Computer Project 2 
## Features: 
The final project is about a simulated minipiano with Arduino and Processing. It can be played through the physical buttons that simulate the keys of a piano, as in the piano proposed by Processing. 
You can also load your own melodies in the Processing code thanks to the pianoSonar class. 

## Format of the melody function 
If you want to load the new tune, you will find something like "Happy Birthday.txt", "Jingle Bells.txt", etc. Well, the format we have arranged is that of a text file, it has the following form that you must follow: 

Note, Duration 
Silence, Duration (optional) 

Note the use of a comma (,) that separates the space after the comma to its duration. After having fulfilled the slogan, you must click "Enter" which in the code will look like: 
Note, Duration\n 
Silence, Duration\n 

### Clarification 
The term "\n" is added when you press "Enter". So you can upload a personalized melody. 
Once finished, note that in the folder where Processing is located there is a folder called "data". Well, it is of vital importance, since if your .txt file or any type of file that is not in said folder, Processing will not be able to access and probably has some conflict. 
## And now? How do I add my melodies if I already have the modeled txt file? 
In order for you to load the file, you must go to Processing precisely the lines: 

123 sonar.loadFileName ("Hymn of Joy.txt"); 
150 sonar.loadFileName ("Jingle Bells.txt"); 
177 sonar.loadFileName ("Happy Birthday.txt");

You only have to change the name of the file and in turn you must save your file in the "data" folder mentioned above. 
For example, I just want to change the 3 melody, as you will need to change the file name including the ("") and the aggregate (.txt) sonar.loadFileName ("ExampleName.txt"); 
## Reminder 
If you do not have the file "ExampleName.txt" in the "data" folder inside the folder where the Processing code is hosted, you will have the following error: nullPointerException 
This means that Processing did not find the file "ExampleName.txt" 

# Acknowledgments 
Thanks for your time, good luck!