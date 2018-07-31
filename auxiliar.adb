with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Numerics.Discrete_Random;


package body Auxiliar is
    subtype Rand_Range is Integer range 0 .. 1;
    package Rand_Int is new Ada.Numerics.Discrete_Random(Rand_Range);
    G : Rand_Int.Generator;
    
    -- adicional
    task body logger is
    begin
        loop
            accept toLog(line : String) do
                Put_Line(line);
            end toLog;
        end loop;
    end logger;

    function herramienta (id: in Integer) return String is
    begin
        if id = 1 then
            return "Batidora ";
        else
            return "Amasadora";
        end if;
    end herramienta;

    -- definidas en la letra
    procedure elaborar(id : in Integer) is
        msgChef : String := "Elabora el chef";
        msgCoci : String := "Elabora el cocinero " & Trim(Integer'Image(id), Ada.Strings.Left);
    begin
        if id = 0 then
            logger.toLog(msgChef);
        else
            logger.toLog(msgCoci);
        end if;
        delay 15.0; -- cocinan en 15 segundos :')
    end elaborar;
    
    procedure ponerEnCaja(id : in Integer; n : in Integer) is
        msgChef : String := "El chef pone en la caja " &  Trim(Integer'Image(n), Ada.Strings.Left);
        msgCoci : String := "El cocinero " & Trim(Integer'Image(id), Ada.Strings.Left) & " pone en la caja " & Trim(Integer'Image(n), Ada.Strings.Left);
    begin
        if id = 0 then
            logger.toLog(msgChef);
        else
            logger.toLog(msgCoci);
        end if;
    end ponerEnCaja;

    procedure cambiarCaja(n : in Integer) is
        msgDesp : String := "EL DESPACHADOR CAMBIA LA CAJA " &  Trim(Integer'Image(n), Ada.Strings.Left);
    begin
        logger.toLog(msgDesp);
    end cambiarCaja;

    procedure avisarSupervisor is
         msgDesp : String := "EL DESPACHADOR AVISA AL SUPERVISOR";
    begin
        logger.toLog(msgDesp);
    end avisarSupervisor;
    
    procedure seleccionChef(mez : out Integer; her : out String) is
        codr : Integer := (Rand_Int.Random(G) mod 2) + 1;
        mezr : Integer := (Rand_Int.Random(G) mod 2) + 1;
        msgChef : String := "Chef selecciona Mezcla " & Trim(Integer'Image(mezr), Ada.Strings.Left) & " y herramienta " & herramienta(codr);
    begin
        mez := mezr; 
        her := herramienta(codr);
        logger.toLog(msgChef);
    end seleccionChef;

    procedure TomarHerramienta(id : in Integer; her : in String) is
        msgChef : String := "El chef toma la herramienta " &  her;
        msgCoci : String := "El cocinero " & Trim(Integer'Image(id), Ada.Strings.Left) & " toma la herramienta " & her;
    begin
        if id = 0 then
            logger.toLog(msgChef);
        else
            logger.toLog(msgCoci);
        end if;
    end TomarHerramienta;
        
    procedure TomarMezcla(id : in Integer; mez : in Integer) is
        msgChef : String := "El chef toma la Mezla " &  Trim(Integer'Image(mez), Ada.Strings.Left);
        msgCoci : String := "El cocinero " & Trim(Integer'Image(id), Ada.Strings.Left) & " toma la Mezcla " & Trim(Integer'Image(mez), Ada.Strings.Left);
    begin
        if id = 0 then
            logger.toLog(msgChef);
        else
            logger.toLog(msgCoci);
        end if;
    end TomarMezcla;

end Auxiliar;
