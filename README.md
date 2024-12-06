# Proyecto Final Informatica 2
##Funcionalidades:
El proyecto final trata sobre un minipiano simulado con Arduino y Processing. Se puede tocar a través de los botones fisicos que simulan las teclas de un piano, como en el piano propuesto por Processing.
Además se pueden cargar melodías propias en el código de Processing, en las funciones cargarMelodia1 (), cargarMelodia2 (), cargarMelodia3 ().
##Formato de la función melodía
Sí usted desea cargar la melodía nueva, se encontrará algo como "Feliz cumpleaños.txt", "Jingle Bells.txt", etc.
Pues el formato que hemos dispuesto es el de un archivo de texto, el mismo tiene la siguiente forma que usted debe seguir:

Nota, Duración

Notese el uso de una coma (,) que separa junto al espacio después de la coma a la duración de la misma. Luego haber cumplido la consigna deberá clickear "Enter" que en el código se verá como:
Nota, Duración\n

El termino "\n" se agrega cuando usted presiona "Enter".
Así usted podrá cargar una melodía personalizada.
Una vez termine, observe que en la carpeta donde se encuentra Processing existe una carpeta llamada "data". Pues es de vital importancia, ya qué si su archivo .txt o cualquier tipo de archivo que no se encuentre en dicha carpeta, Processing no podrá acceder y probablemente tenga algún conflicto.
Sin más que agregar por ahora