# Cumplo

Obten la información de la UF, Dolar del periodo que consultes,
para ello tienes que primero registrarte

## Instalación

Ejecuta en tu consola

    $ bundle
    $ rails db:create
    $ rails db:migrate

Para que tengas la informacion de sbif en tu local ejecuta la siguente tarea

    $ rails sbif:default_data

Después de termina la tarea

    $ rails s

## Relevante

la aplicacion cuenta con jobs >> SettingSbifJob, que se ejecuta una vez al dia a las 00:05 para actualizar la informacion de la UF y Dolar del periodo actual.

O ejecutar en consola la tarea asociada para el ajuste diario

    $ rails sbif:daily_setting
