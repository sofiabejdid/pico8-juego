# pico8-juego

## Descripción general
El jugador controla una canasta en la parte inferior de la pantalla con el objetivo de recolectar frutas que caen del cielo y evitar objetos peligrosos. A medida que aumenta el puntaje, la velocidad de caída de los objetos se incrementa y el ambiente/fondo cambia dinámicamente de color.

Este proyecto fue desarrollado con la metodología Vibe Coding (creación con inteligencia artificial mediante lenguaje natural sin edición manual directa del código Lua).

## Controles y funcionamiento
flechas -> y <- para moverse en ambas direcciones. 
Objetos Buenas (Frutas): Suman 1 punto al ser atrapados (Manzana, banana, cerezas)
Objetos Malos (Peligros): Restan 1 vida al ser atrapados (bomba, roca con púas).


## Reflexiones
-Las mecánicas del juego mas dificiles de comunicar fueron en primer lugar explicar en palabras cómo calcular la colisión de un objeto circular/cuadrado con la canasta para que no se viera "flotando" o entrando demasiado en el borde. Tambien por otro lado la estética, inicialmente la canasta era un rectangulo amarillo y luego de varias iteraciones llegamos al resultado que yo me imaginaba. 

-Si bien la ia escribe el codigo, las habilidades que siguen siendo indispensables son la lógica y la descomposición: saber estructurar el problema en fases (inicialización, actualización, etc). Tambien el criterio propio de validación, poder distinguir qué está mal, por qué, identificar casos de prueba.

-Se evitó caer en bucles infinitos de corrección desglosando los pedidos a la ia: en lugar de pedir que arregle todo de una vez, se aisló la lógica del movimiento, luego la de colisiones y finalmente la estetica.
