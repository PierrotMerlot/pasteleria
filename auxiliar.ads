package Auxiliar is

    -- adicional
    task logger is
        entry toLog(line : in String);
    end logger;
    function herramienta (id: in Integer) return String;

    -- definidas en la letra
    procedure elaborar(id : in Integer); -- id es el identificador del cocinero, 0 si es el chef
    procedure ponerEnCaja(id : in Integer; n : in Integer);
    procedure cambiarCaja(n : in Integer);
    procedure avisarSupervisor;
    procedure seleccionChef(mez : out Integer; her : out String);
    procedure TomarHerramienta(id : in Integer; her : in String);
    procedure TomarMezcla(id : in Integer; mez : in Integer);

end Auxiliar;
