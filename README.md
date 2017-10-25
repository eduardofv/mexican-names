# Nombres Mexicanos

Para generar un dataset representativo de los nombres de personas en México se usó una idea tomada de [datamx](http://datamx.io/dataset/nombres-mas-comunes-en-mexico) que utiliza una [base de datos abierta de la Secretaría de Educación Pública](http://cumplimientopef.sep.gob.mx/registro_personal/) con los nombres de 1,256,438 trabajadores federalizados. 

La limpieza y el procesamiento de los datos está en [analizar_nombres_sep.R](analizar_nombres_sep.R). Realiza lo siguiente:

* Elimina duplicados usando como llave el CURP
* Obtiene el género a partir del caracter 11 del CURP
* Obtiene el año de nacimiento de los caracteres 5 y 6 del CURP
* Calcula la edad de cada registro al año 2012 que es el de actualización según la página de la SEP
* Calcula las frecuencias de los primeros y segundos apellidos, elimina los que tienen una frecuencia menor a 5 y elimina algunos que son basura o nulos. Crea un solo data frame y lo guarda.
* Divide el dataset en Hombres y Mujeres, calcula las frecuencias de los nombres en cada caso, elimina los que tienen una frecuencia menor a 5, calcula la edad promedio para cada nimbre y guarda el data frame

Se usa un formato similar al de los [nombres y apellidos frecuentes en España](https://github.com/marcboquet/spanish-names/) de donde se inspiró este proyecto. Hay que notar que es una muestra grande pero dos órdenes de magnitud menor a lo que sería una completa y que está segmentada al ser únicamente trabajadores de la SEP. Los archivos originales y procesados estan en [data/sep](data/sep).

[Repositorio en datos abiertos](http://datamx.io/dataset/muestra-de-nombres-y-apellidos-comunes-en-mexico)

