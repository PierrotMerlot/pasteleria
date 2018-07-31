# Ejercicio de concurrencia en Ada

En una pastelería se cuenta con 3 cocineros especializados, 1 chef, 1 batidora, 1 amasadora y 3 recipientes con mezclas diferentes. El plano de la pastelería es el siguiente:

```text
                       ______
                      |      |
                      |Caja 2|
                      |______|
                     __________
                    |          |
                    | Mezcla 3 | Mostrador 2
                    |__________|
                    
                       [Chef]
 ___________________________________________________
|                                                   |
|Batidora      Mezcla 1      Amasadora      Mezcla 2| Mostrador 1
|___________________________________________________|
     \        /    \        /      \        /
      \      /      \      /        \      /    
    [Cocinero 1]   [Cocinero 2]   [Cocinero 3]
                     ______
                    |      |
                    |Caja 1|
                    |______|
```

Los cocineros cocinan con la mezcla y la herramienta adyacentes tomando siempre primero el elemento de la izquierda y luego el de la derecha. El chef, en cambio, usa una mezcla y una herramienta cualquiera del Mostrador 1 (tomadas en ese orden) junto con la Mezcla 3.
Lo producido por los cocineros se guarda en la Caja 1, que tiene lugar para 6 elaboraciones, mientras que lo realizado por el chef se guarda en la Caja 2, con capacidad para 4 elaboraciones. Una vez completada una caja el despachador la retira y pone una nueva. Si el despachador está más de 15 minutos esperando que se complete una caja avisa al supervisor.

Se desea modelar usando ADA los procesos cocinero, chef y despachador. Se pueden usar tareas auxiliares.

* elaborar()

Ejecutado por el chef y los cocineros una vez que tienen los elementos necesarios.

* ponerEnCaja()

Ejecutado por el chef y los cocineros una vez que terminan la elaboración.

* cambiarCaja()

Ejecutado por el despachador para cambiar una caja llena.

* avisarSupervisor()

Ejecutada por el despachador para avisar al supervisor.

* seleccionChef(): [integer, string]

Ejecutada por el chef para seleccionar mezcla y herramienta a usar. Retorna 1 o 2 para la mezcla y "Amasadora" o "Batidora" para la herramienta.

* tomarMezcla(integer)

Ejecutada por el cocinero o el chef para tomar una mezcla.
